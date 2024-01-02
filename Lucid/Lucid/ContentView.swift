//
//  ContentView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var appDelegate: AppDelegate
    
    var body: some View {
        ZStack {
            if appDelegate.showIndicator {
                LoadingIndicatorHostingView()
            }
            WindowAlertHostingView()
            NavigationStack {
                MainRootView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
