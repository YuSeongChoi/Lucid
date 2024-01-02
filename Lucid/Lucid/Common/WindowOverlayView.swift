//
//  WindowOverlayView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/29/23.
//

import SwiftUI

public struct WindowOverlayView<Content: View>: View {
    
    @usableFromInline
    internal init(level: CGFloat, isHidden: Bool, content: Content) {
        self.level = level
        self.isHidden = isHidden
        self.content = content
    }
    
    @inlinable
    init(level: CGFloat, isHidden: Bool, @ViewBuilder content: () -> Content) {
        self.init(level: level, isHidden: isHidden, content: content())
    }
    
    public var level: CGFloat
    public var isHidden: Bool
    public var content: Content
    
    @inlinable
    public var body: some View {
        OverlayWindowHost(content: content, isHidden: isHidden, level: .init(level))
            .frame(width: 0, height: 0)
    }
    
}

public extension WindowOverlayView where Content == EmptyView {
    
    @inlinable
    init() {
        self.init(level: 0, isHidden: true, content: .init())
    }
    
}

@usableFromInline
struct OverlayWindowHost<Content>: UIViewRepresentable where Content: View {
    
    @usableFromInline
    internal init(content: Content, isHidden: Bool, level: UIWindow.Level) {
        self.content = content
        self.isHidden = isHidden
        self.level = level
    }
    
    @usableFromInline
    typealias UIViewType = WindowCallbackUIView
    @usableFromInline
    typealias Coordinator = OverlayWindow
    
    var content: Content
    var isHidden: Bool
    var level: UIWindow.Level
    
    @usableFromInline
    func makeCoordinator() -> OverlayWindow {
        let window = OverlayWindow()
        window.isHidden = true
        window.backgroundColor = nil
        return window
    }
    
    @usableFromInline
    func makeUIView(context: Context) -> UIViewType {
        let view = UIViewType()
        let rootView = content.modifier(EnvironmentValueModifier(environment: context.environment))
        let vc = UIHostingController(rootView: rootView)
        view.callBack = { [weak coordinator = context.coordinator] scene in
            coordinator?.windowScene = scene
        }
        vc.view.backgroundColor = nil
        withTransaction(context.transaction) {
            context.coordinator.rootViewController = vc
        }
        return view
    }
    
    @usableFromInline
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.callBack = { [weak coordinator = context.coordinator] scene in
            coordinator?.windowScene = scene
        }
        context.coordinator.windowLevel = level
        context.coordinator.isHidden = isHidden
        context.coordinator.isUserInteractionEnabled = context.environment.isEnabled
        let rootView = content.modifier(EnvironmentValueModifier(environment: context.environment))
        switch context.coordinator.rootViewController {
        case let vc as UIHostingController<ModifiedContent<Content, EnvironmentValueModifier>>:
            withTransaction(context.transaction) {
                vc.rootView = rootView
            }
        case .none:
            let vc = UIHostingController(rootView: rootView)
            vc.view.backgroundColor = nil
            withTransaction(context.transaction) {
                context.coordinator.rootViewController = vc
            }
        case let .some(some):
            assertionFailure("\(type(of: some)) is not recognized")
            let vc = UIHostingController(rootView: rootView)
            vc.view.backgroundColor = nil
            withTransaction(context.transaction) {
                context.coordinator.rootViewController = vc
            }
        }
    }
    
}

@MainActor
@usableFromInline
final class OverlayWindow: UIWindow {
    
    @inlinable
    nonisolated
    override var canBecomeKey: Bool { false }
    
    @inlinable
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let targetView = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == targetView ? nil : targetView
    }
    
}

@usableFromInline
struct EnvironmentValueModifier: ViewModifier {
    
    @usableFromInline
    var environment: EnvironmentValues
    
    @inlinable
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(environment.colorScheme)
            .disabled(!environment.isEnabled)
            .font(environment.font)
            .environment(\.scenePhase, environment.scenePhase)
    }
    
}
