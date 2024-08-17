//
//  ServerConfig.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation
import NetworkExtension

let ServerConstant: ServerConfiguration = {
    let config: ServerConfiguration
    config = .Maple
    return config
}()

var API_KEY: String {
    guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return "" }
    return key
}

struct ServerConfiguration: Hashable, Sendable {
    var baseURL: String
}

extension ServerConfiguration {
    static var Maple: Self {
        .init(baseURL: "https://open.api.nexon.com")
    }
}
