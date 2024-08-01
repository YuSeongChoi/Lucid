//
//  SearchViewModel.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import Alamofire

@MainActor
final class SearchViewModel: ObservableObject, Identifiable {
    
    @Published var ocid: String = ""
    @Published var basicInfo: CharacterBasicVO = .init()
    @Published var mainCharacterInfo: CharacterBasicVO = .init()
    
    var taskStorage: Set<Task<Void,Never>> = []
    
}

// MARK: - Request APIs
extension SearchViewModel {
    
    /// 캐릭터 UUID 조회
    func requestCharacterID(name: String) async throws {
        do {
            let result = try await HTTPRequestList.CharacterIDRequest(character_name: name)
                .buildDataRequest()
                .serializingDecodable(CharacterIDVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            self.ocid = result.ocid
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
    }
     
    /// 캐릭터 기본 정보 조회
    func requestBasicInfo() async throws -> CharacterBasicVO {
        do {
            return try await HTTPRequestList.CharacterBasicInfoRequest(ocid: self.ocid)
                .buildDataRequest()
                .serializingDecodable(CharacterBasicVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
        } catch {
            throw error
        }
    }
    
    /// 캐릭터 디테일 정보 조회
    func requestDetailInfo() async throws {
        do {
            let result = try await HTTPRequestList.CharacterDetailInfoRequest(ocid: self.ocid)
                .buildDataRequest()
                .serializingDecodable(CharacterDetailVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
//            print("detail : \(result)")
        } catch {
            
        }
    }
    
    /// 캐릭터 유니언 공격대 정보 조회
    func requestUnionRaiderInfo() async throws {
        do {
            let result = try await HTTPRequestList.UnionRaiderInfoRequest(ocid: self.ocid)
                .buildDataRequest()
                .serializingDecodable(UnionRaiderVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
        } catch {
            
        }
    }
    
    /// 유니온 랭킹 정보 조회
    func requestUnionRankingInfo() async throws {
        do {
            let result = try await HTTPRequestList.UnionRankingInfoRequest(ocid: self.ocid)
                .buildDataRequest()
                .serializingDecodable(UnionRanking.UnionRankingRepo.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            
            if let mainCharacter = result.ranking.first {
                try await requestCharacterID(name: mainCharacter.character_name)
                mainCharacterInfo = try await requestBasicInfo()
            }
        } catch {
            
        }
    }
        
}
                     
