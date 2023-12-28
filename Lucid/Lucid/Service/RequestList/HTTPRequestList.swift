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
    
    struct UserIDRequest: DataRequestFormProtocol, Encodable {
        var path: String { "" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
    }
    
}
