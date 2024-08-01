//
//  RankingVO.swift
//  Lucid
//
//  Created by YuSeongChoi on 8/1/24.
//

import Foundation

import CodableWrappers

/// 유니온 랭킹 정보
struct UnionRanking: Codable, Hashable {
    /// 랭킹 업데이트 일자(KST)
    var date: String = ""
    /// 유니온 랭킹 순위
    var ranking: Int32 = 0
    /// 캐릭터 명
    var character_name: String = ""
    /// 월드 명
    var world_name: String = ""
    /// 직업 명
    var class_name: String = ""
    /// 전직 직업 명
    var sub_class_name: String = ""
    /// 유니온 레벨
    var union_level: Int32 = 0
    /// 유니온 파워
    var union_power: Int64 = 0
    
    struct UnionRankingRepo: Codable, Hashable {
        var ranking: [UnionRanking]
    }
}

