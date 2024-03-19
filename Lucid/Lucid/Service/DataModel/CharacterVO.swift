//
//  CharacterVO.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import CodableWrappers

struct CharacterIDVO: Codable, Hashable {
    var ocid: String
}

struct CharacterBasicVO: Codable, Hashable {
    /// 조회 기준일(KST, 일 단위 데이터로 시,분은 일괄 0으로 표기)
    var date: String
    /// 캐릭터 명
    var character_name: String
    ///필드 명
    var world_name: String
    /// 캐릭터 성별
    var character_gender: String
    /// 캐릭터 직업
    var character_class: String
    /// 캐릭터 전직 차수
    var character_class_level: String
    /// 캐릭터 레벨
    var character_level: Int64
    /// 현재 레벨에서 보유한 경험치
    var character_exp: Int64
    /// 현재 레벨에서 경험치 퍼센트
    var character_exp_rate: String
    /// 캐릭터 소속 길드 명
    var character_guild_name: String
    /// 캐릭터 외형 이미지
    var character_image: String
}

struct CharacterDetailVO: Codable, Hashable {
    /// 조회 기준일
    var date: String
    /// 캐릭터 직업
    var character_class: String
    /// 현재 스탯 정보
    var final_stat: [StatVO]
    /// 잔여 ap
    var remain_ap: Int64
}

struct StatVO: Codable, Hashable {
    /// 스탯 명
    var stat_name: String
    /// 스탯 값
    var stat_value: String
}
