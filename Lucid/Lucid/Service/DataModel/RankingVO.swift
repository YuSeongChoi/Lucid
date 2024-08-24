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

/// 종합 랭킹 정보
struct OveralRankingVO: Codable, Hashable {
    /// 랭킹 업데이트 일자
    var date: String = ""
    /// 종합 랭킹 순위
    var ranking: Int32 = 0
    /// 캐릭터 명
    var character_name: String = ""
    /// 월드 명
    var world_name: String = ""
    /// 직업 명
    var class_name: String = ""
    /// 전직 직업 명
    var sub_class_name: String = ""
    /// 캐릭터 레벨
    var character_level: Int32 = 0
    /// 캐릭터 경험치
    var character_exp: Int64 = 0
    /// 캐릭터 인기도
    var character_popularity: Int32 = 0
    /// 길드 명
    var character_guildname: String = ""
    
    struct OveralRankingRepo: Codable, Hashable {
        var ranking: [OveralRankingVO] = []
    }
}
