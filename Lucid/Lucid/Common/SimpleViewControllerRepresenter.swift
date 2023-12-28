//
//  SimpleViewControllerRepresenter.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct SimpleViewControllerRepresenter<ViewController:UIViewController>: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    let controller:@MainActor (Context) -> ViewController
    var update:@MainActor (ViewController, Context) -> () = { _, _ in }
    func makeUIViewController(context: Context) -> ViewController {
        controller(context)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        update(uiViewController, context)
    }
    
}

extension SimpleViewControllerRepresenter {
    init(controller: @autoclosure @escaping @MainActor () -> ViewController, update:  @escaping @MainActor (ViewController, Context) -> () = { _, _ in }) {
        self.controller = { _ in controller() }
        self.update = update
    }
}

struct SimpleViewRepresenter<SimpleView:UIView>: UIViewRepresentable {
    typealias UIViewType = SimpleView
    
    let view:@MainActor (Context) -> SimpleView
    
    var update:@MainActor (SimpleView, Context) ->() = {_, _ in }
    
    func makeUIView(context: Context) -> SimpleView {
        view(context)
    }
    
    func updateUIView(_ uiView: SimpleView, context: Context) {
        update(uiView, context)
    }
    
}

extension SimpleViewRepresenter {
    init(view: @MainActor @autoclosure @escaping () -> SimpleView, update:@MainActor @escaping (SimpleView, Context) -> () = {_, _ in }) {
        self.view = { _ in view() }
        self.update = update
    }
}

struct ClosureUIViewRepresenter<ViewType:UIView, CoordinatorType>: UIViewRepresentable {
    func makeCoordinator() -> CoordinatorType {
        coordinate()
    }
    
    typealias UIViewType = ViewType
    typealias Coordinator = CoordinatorType
    
    let view:(Context) -> ViewType
    let coordinate:() -> Coordinator
    var update:(ViewType, Context) ->() = {_, _ in }
    
    func makeUIView(context: Context) -> ViewType {
        view(context)
    }
    
    func updateUIView(_ uiView: ViewType, context: Context) {
        update(uiView, context)
    }
}

