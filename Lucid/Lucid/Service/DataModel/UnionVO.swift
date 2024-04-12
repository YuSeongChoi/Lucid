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
    /// 유니온 블록 정보
    var union_block: [UnionBlockVO]
    /// 적용 중인 프리셋 번호
    var use_preset_no: Int64
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
    /// 블록 모양(전사, 마법사, 궁수, 도적, 해적, 메이플m, 하이브리드)
    var block_type: String
    /// 블록 해당 캐릭터 직업
    var block_class: String
    /// 블록 해당 캐릭터 레벨
    var block_level: String
    /// 블록 기준점 좌표
    /// 중앙 4칸 오른쪽 아래 칸이 x:0, y:0 포지션
    /// 좌측으로 1칸씩 이동하면 x가 1씩 감소
    /// 우측으로 1칸씩 이동하면 x가 1씩 증가
    /// 아래로 1칸씩 이동하면 y가 1씩 감소
    /// 위로 1칸씩 이동하면 y가 1씩 증가
    var block_control_point: UnionPointVO
    /// 블록이 차지하고 있는 영역 좌표들(null: 미 배치시)
    var block_position: [UnionPointVO]
}

/// 유니온 블록 좌표
struct UnionPointVO: Codable, Hashable {
    /// 블록 기준점 x좌표
    var x: Int64
    /// 블록 기준점 y좌표
    var y: Int64
}

/// 유니온 프리셋 정보
struct UnionPresetVO: Codable, Hashable {
    
}
