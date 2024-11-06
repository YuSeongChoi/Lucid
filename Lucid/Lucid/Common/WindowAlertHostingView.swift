//
//  WindowAlertHostingView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/29/23.
//

import SwiftUI

struct WindowAlertHostingView: View {
    
    static var AlertNotificationName: Notification.Name {
        .init("Lucid.WindowAlertHosting.NetworkError.Name")
    }
    
    static var AlertDismissNotificationName: Notification.Name {
        .init("Lucid.WindowAlertHosting.NetworkErrorDismiss.Name")
    }
    
//    @State private var error: Error? = nil
    @State private var errorMessage: String = ""
    @State private var isPresented = false
    
    var body: some View {
        Group {
            if isPresented {
                windowView
            } else {
                EmptyView()
            }
        }
        .frame(width: 0, height: 0)
        .onReceive(
            NotificationCenter.default.publisher(for: Self.AlertNotificationName)
                .compactMap{ $0.object as? [String: String] }
                .receive(on: DispatchQueue.main)
        ) { data in
            self.errorMessage = data["errorMessage"] ?? "에러가 발생했습니다."
            self.isPresented = true
        }
        .onReceive(
            NotificationCenter.default.publisher(for: Self.AlertDismissNotificationName)
                .receive(on: DispatchQueue.main)
        ) { _ in
            self.errorMessage = ""
            self.isPresented = false
        }
    }
    
    @ViewBuilder
    private var windowView: some View {
        WindowOverlayView(level: UIWindow.Level.normal.rawValue + 0.2, isHidden: false) {
            Spacer()
                .alert(errorMessage, isPresented: $isPresented) {
                    return EmptyView()
                }
        }
    }
    
}

struct APIError: Codable {
    let error: ErrorDetail
    
    struct ErrorDetail: Codable {
        let name: String
        let message: String
    }
}
