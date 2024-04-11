//
//  UnionVO.swift
//  Lucid
//
//  Created by YuSeongChoi on 4/11/24.
//

import Foundation

import CodableWrappers

struct UnionVO: Codable, Hashable {
    var date: String
    /// 유니온 공격대원 효과
    var union_raider_stat: [String]
    /// 유니온 공격대 점령 효과
    var union_occupied_stat: [String]
    /// 유니온 공격대 배치
    var union_inner_state: [UnionInnerStatVO]
    
}

/// 유니온 공격대 배치
struct UnionInnerStatVO: Codable, Hashable {
    /// 공격대 배치 위치(11시 방향부터 시계 방향 순서대로 0~7)
    var stat_field_id: String
    /// 해당 지역 점령 효과
    var stat_field_effect: String
}

/// 유니온 블록 정보
struct UnionBlockVO: Codable, Hashable {
    
}
