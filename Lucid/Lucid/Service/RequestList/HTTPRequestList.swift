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
        var validation: DataRequest.Validation? { ValidationError.errorValidation }
        var character_name: String
    }
    
    // MARK: 캐릭터 인기도 정보 조회
    struct CharacterPopularityRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/character/popularity" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
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
    
    // MARK: 장착 장비 정보 조회(캐시 장비 제외)
    struct CharacterItemEquipmentInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/character/item-equipment" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
    }
    
    // MARK: 유니온 정보 조회
    struct UnionBasicInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/user/union" }
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
    
    // MARK: 유니온 랭킹 정보 조회
    struct UnionRankingInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/ranking/union" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
    }
    
    // MARK: 종합 랭킹 정보 조회
    struct RankingOverallInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/ranking/overall" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var ocid: String
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
        var world_name: String? = nil
        /// 월드 타입(0:일반, 1: 리부트)
        var world_type: Int8? = nil
        var `class`: String? = nil
        var page: Int32? = nil
        
        func asURLRequest() throws -> URLRequest {
            var parameters: [String: Encodable] = [
                "ocid": ocid,
                "date": date
            ]
            
            if let world_name = world_name, !world_name.isEmpty {
                parameters["world_name"] = world_name
            }
            if let world_type = world_type {
                parameters["world_type"] = world_type
            }
            if let `class` = `class`, !`class`.isEmpty {
                parameters["class"] = `class`
            }
            if let page = page {
                parameters["page"] = page
            }
            
            return try encoder.encodeErased(parameters, into: baseRequest)
        }
    }
    
    // MARK: 무릉도장 최고 기록 정보 조회
    struct DojangBestRecordInfoRequest: DataRequestFormProtocol, Encodable {
        var path: String { "maplestory/v1/character/dojang" }
        var method: HTTPMethod { .get }
        var validation: DataRequest.Validation? { nil }
        var date: String = Date().addDay(n: -1).string(format: "yyyy-MM-dd")
        var ocid: String
    }
    
}
