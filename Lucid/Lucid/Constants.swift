//
//  Constants.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

enum Constants {
    
    enum MainTabItem: String, Hashable {
        case search
        case info
        case setting
        
        var title: String {
            switch self {
            case .search:
                return "검색"
            case .info:
                return "정보"
            case .setting:
                return "설정"
            }
        }
    }
    
}
