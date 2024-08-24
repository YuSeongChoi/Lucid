//
//  AnyEncodable.swift
//  Lucid
//
//  Created by YuSeong on 8/24/24.
//

import Foundation

import Alamofire

public struct AnyEncodable: Encodable {
    
    public let value: any Encodable
    
    @inlinable
    public init(_ wrapped: Encodable) {
        self.value = wrapped
    }
    
    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
    
}

extension ParameterEncoder {
    func encodeErased(_ parameters: [String: Encodable], into request: URLRequest) throws -> URLRequest {
        try encode(parameters.mapValues(AnyEncodable.init), into: request)
    }
}
