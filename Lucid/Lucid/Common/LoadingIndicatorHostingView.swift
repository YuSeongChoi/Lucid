//
//  LoadingIndicatorHostingView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/29/23.
//

import SwiftUI

import Alamofire
import AsyncAlgorithms

struct LoadingIndicatorHostingView: View {
    
    @EnvironmentObject private var appDelegate: AppDelegate
    @Environment(\.scenePhase) private var scenePhase
    @State private var taskRunning: Bool = false
    
    private var isLoading: Bool {
        taskRunning && scenePhase == .active
    }
    
    var body: some View {
        ZStack {
            Color.clear
            if isLoading {
                WindowOverlayView(level: UIWindow.Level.normal.rawValue + 0.1, isHidden: false) {
                    ZStack {
                        Color.white.opacity(0.01)
//                        IndicatorView()
//                            .frame(width: 40, height: 40)
//                            .background(Color.clear)
                        ProgressView()
                            .frame(width: 40, height: 40)
                            .background(Color.clear)
                    }
                }
            }
        }
        .frame(maxWidth: .leastNormalMagnitude, maxHeight: .leastNormalMagnitude)
        .task {
            await observeTask()
        }
    }
    
    nonisolated
    private func observeTask() async {
        let transformer: (@Sendable (Notification) -> Void?) = {
            guard let request = $0.request as? DataRequest, !(request.convertible is PrefetchRequestProtocol) else {
                return nil
            }
            return ()
        }
        
        let beginSignalBuffer = {
            var iterator = NotificationCenter.default.notifications(named: Request.didResumeTaskNotification)
                .compactMap(transformer).makeAsyncIterator()
            return AsyncStream(unfolding: { await iterator.next() }).buffer(policy: .unbounded)
        }()
        
        var terminateSignalIterator = {
            var suspendIterator = NotificationCenter.default.notifications(named: Request.didSuspendNotification)
                .compactMap(transformer).makeAsyncIterator()
            var completeIterator = NotificationCenter.default.notifications(named: Request.didCompleteTaskNotification)
                .compactMap(transformer).makeAsyncIterator()
            // wrap into AsyncStream to disable Sendable unavailable warning
            return merge(
                AsyncStream{ await suspendIterator.next() },
                AsyncStream{ await completeIterator.next() }
            ).buffer(policy: .unbounded).makeAsyncIterator()
        }()
        
        for await _ in beginSignalBuffer {
            async let pending: Void = await MainActor.run{ taskRunning = true }
            if let _ = await terminateSignalIterator.next() {
                await pending
                await MainActor.run {
                    taskRunning = false
                }
                break
            }
        }
    }
    
    struct IndicatorView: UIViewRepresentable {
        
        func makeUIView(context: Context) -> some UIView {
            let view = UIImageView()
            view.image = UIImage.animatedImageNamed("imgLoading/loadingbar", duration: 0.9)
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        
    }
    
}
