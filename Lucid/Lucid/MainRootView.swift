//
//  MainRootView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct MainRootView: View {
    
    typealias TabItemType = Constants.MainTabItem
    
    @State private var tabSelection: TabItemType = .search
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelection) {
                SearchView()
                    .tag(TabItemType.search)
                    .tabItem {
                        Label("조회", systemImage: "house.fill")
                    }
                
                InfoView()
                    .tag(TabItemType.info)
                    .tabItem {
                        Label("정보", systemImage: "crown.fill")
                    }
                
                SettingView()
                    .tag(TabItemType.setting)
                    .tabItem {
                        Label("설정", systemImage: "gearshape")
                    }
            }
            .accentColor(.lightishPurple)
        }
    }
    
}
