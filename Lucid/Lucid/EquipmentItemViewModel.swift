//
//  EquipmentItemViewModel.swift
//  Lucid
//
//  Created by YuSeong on 8/17/24.
//

import Foundation

import Alamofire

@MainActor
final class EquipmentItemViewModel: Identifiable, ObservableObject {
    /// 유니온 정보
    @Published var unionInfo: UnionBasicVO = .init()
    /// 인기도
    @Published var characterPopularity: Int64 = 0
    /// 전체랭킹
    @Published var totalRanking: Int32 = 0
    /// 서버랭킹
    @Published var serverRanking: Int32 = 0
    /// 무릉도장 최고 층수
    @Published var dojangBestRecord: Int64 = 0
    
    var taskStorage: Set<Task<Void,Never>> = []
    
}


// MARK: - Request APIs
extension EquipmentItemViewModel {
    
    /// 유니온 정보 조회
    func requestUnionInfo(ocid: String) async throws {
        do {
            let result = try await HTTPRequestList.UnionBasicInfoRequest(ocid: ocid)
                .buildDataRequest()
                .serializingDecodable(UnionBasicVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            self.unionInfo = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 인기도 정보 조회
    func requestPopularityInfo(ocid: String) async throws {
        do {
            let result = try await HTTPRequestList.CharacterPopularityRequest(ocid: ocid)
                .buildDataRequest()
                .serializingDecodable(PopularityVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            self.characterPopularity = result.popularity
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// 랭킹 정보 조회
    func requestOverallRankingInfo(ocid: String, world_name: String, world_type: Int) async throws -> Int32 {
        do {
            let result = try await HTTPRequestList.RankingOverallInfoRequest(ocid: ocid, world_name: world_name, world_type: Int8(world_type))
                .buildDataRequest()
                .serializingDecodable(OveralRankingVO.OveralRankingRepo.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            return result.ranking.first?.ranking ?? 0
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
    
    /// 무릉도장 최고 기록 조회
    func requestDojangBestRecordInfo(ocid: String) async throws {
        do {
            let result = try await HTTPRequestList.DojangBestRecordInfoRequest(ocid: ocid)
                .buildDataRequest()
                .serializingDecodable(CharacterDojangVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            self.dojangBestRecord = result.dojang_best_floor
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
