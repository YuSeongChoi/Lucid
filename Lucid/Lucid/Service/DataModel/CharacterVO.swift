//
//  CharacterVO.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import CodableWrappers

/// 고유(oicd) 값
struct CharacterIDVO: Codable, Hashable {
    var ocid: String
}

/// 캐릭터 기본 정보
struct CharacterBasicVO: Codable, Hashable {
    /// 조회 기준일(KST, 일 단위 데이터로 시,분은 일괄 0으로 표기)
    var date: String = Date().string(format: "yyyy-MM-dd")
    /// 캐릭터 명
    @FallbackDecoding<EmptyString>
    var character_name: String = ""
    ///필드 명
    @FallbackDecoding<EmptyString>
    var world_name: String = ""
    /// 캐릭터 성별
    @FallbackDecoding<EmptyString>
    var character_gender: String = ""
    /// 캐릭터 직업
    @FallbackDecoding<EmptyString>
    var character_class: String = ""
    /// 캐릭터 전직 차수
    @FallbackDecoding<EmptyString>
    var character_class_level: String = ""
    /// 캐릭터 레벨
    @FallbackDecoding<EmptyInt64>
    var character_level: Int64 = 0
    /// 현재 레벨에서 보유한 경험치
    @FallbackDecoding<EmptyInt64>
    var character_exp: Int64 = 0
    /// 현재 레벨에서 경험치 퍼센트
    @FallbackDecoding<EmptyString>
    var character_exp_rate: String = ""
    /// 캐릭터 소속 길드 명
    @FallbackDecoding<EmptyString>
    var character_guild_name: String = ""
    /// 캐릭터 외형 이미지
    @FallbackDecoding<EmptyString>
    var character_image: String = ""
}

/// 캐릭터 상세 정보
struct CharacterDetailVO: Codable, Hashable {
    /// 조회 기준일
    var date: String = Date().string(format: "yyyy-MM-dd")
    /// 캐릭터 직업
    @FallbackDecoding<EmptyString>
    var character_class: String = ""
    /// 현재 스탯 정보
    var final_stat: [StatVO] = []
    /// 잔여 ap
    @FallbackDecoding<EmptyInt64>
    var remain_ap: Int64 = 0
}

/// 스탯정보
struct StatVO: Codable, Hashable {
    /// 스탯 명
    var stat_name: String = ""
    /// 스탯 값
    var stat_value: String = ""
}

/// 인기도
struct PopularityVO: Codable, Hashable {
    var date: String
    var popularity: Int64
}

struct CharacterDojangVO: Codable, Hashable {
    /// 조회 기준일
    @FallbackDecoding<EmptyString>
    var date: String = ""
    /// 캐릭터 직업
    @FallbackDecoding<EmptyString>
    var character_class: String = ""
    /// 월드 명
    @FallbackDecoding<EmptyString>
    var world_name: String = ""
    /// 무릉도장 최고 기록 층수
    @FallbackDecoding<EmptyInt64>
    var dojang_best_floor: Int64 = 0
    /// 무릉도장 최고 기록 달성 일(KST, 일 단위 데이터로 시,분은 일괄 0으로 표기)
    @FallbackDecoding<EmptyString>
    var date_dojang_record: String = ""
    /// 무릉도장 최고 층수 클리어에 걸린 시간(초)
    @FallbackDecoding<EmptyInt64>
    var dojang_best_time: Int64 = 0
}
