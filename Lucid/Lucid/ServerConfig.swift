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

struct ServerConfiguration: Hashable, Sendable {
    var baseURL: String
}

extension ServerConfiguration {
    static var Maple: Self {
        .init(baseURL: "https://open.api.nexon.com")
    }
}
