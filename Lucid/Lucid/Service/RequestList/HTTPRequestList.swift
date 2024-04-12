//
//  HTTPRequestList.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import Alamofire

public enum HTTPRequestList {}

extension HTTPRequestList {
    
    // MARK: 캐릭터 식별자(ocid) 조회
    struct CharacterIDRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/id" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var character_name: String
    }
    
    // MARK: 캐릭터 기본 정보 조회
    struct CharacterBasicInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/character/basic"}
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
    }
    
    // MARK: 캐릭터 종합 능력치 정보 조회
    struct CharacterDetailInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/character/stat" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
    }
    
    // MARK: 유니온 공격대 정보 조회
    struct UnionRaiderInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/user/union-raider" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
    }
    
}
