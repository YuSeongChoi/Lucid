//
//  NonConformingWrapper.swift
//  Lucid
//
//  Created by YuSeongChoi on 1/31/24.
//

import Foundation

import CodableWrappers

typealias yyyyMMddDateCoding = DateFormatterCoding<yyyyMMddDateStaticCoder>

protocol DateStaticCoderWithStringFilter: DateFormatterStaticCoder, Sendable {
    
    @Sendable 
    static func decode(from decoder: Decoder) throws -> Date
    
    @Sendable 
    static func encode(value: Date, to encoder: Encoder) throws
    
}

extension DateStaticCoderWithStringFilter {
    
    public static func decode(from decoder: Decoder) throws -> Date {
        let stringValue = try String(from: decoder)
        let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected \(Date.self) but could not convert \(stringValue) to Date")
        
        guard !stringValue.isEmpty else {
            throw DecodingError.dataCorrupted(context)
        }
        guard let value = dateFormatter.date(from: stringValue) else {
            throw DecodingError.valueNotFound(self,  context)
        }
        return value
    }
}

struct yyyyMMddDateStaticCoder: DateStaticCoderWithStringFilter {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
