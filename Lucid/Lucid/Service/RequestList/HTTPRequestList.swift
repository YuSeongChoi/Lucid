//
//  HTTPRequestList.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import Alamofire

enum HTTPRequestList {}

extension HTTPRequestList {
    
    struct CharacterIDRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/id" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var character_name: String
    }
    
}
