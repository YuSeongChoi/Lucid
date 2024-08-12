//
//  EquipmentVO.swift
//  Lucid
//
//  Created by YuSeongChoi on 8/12/24.
//

import Foundation

import CodableWrappers

/// 캐릭터 장착 장비
struct CharacterItemEquipmentVO: Codable, Hashable {
    /// 조회 기준일
    var date: String = Date().string(format: "yyyy-MM-dd")
    /// 캐릭터 성별
    var character_gender: String = ""
    /// 캐릭터 직업
    var character_class: String = ""
    /// 적용 중인 장비 프리셋 번호(number)
    var preset_no: Int64 = 0
    /// 장비 정보
    var item_equipment: [EquipmentVO] = []
    /// 1번 프리셋 장비 정보
    var item_equipment_preset_1: [EquipmentVO] = []
    /// 2번 프리셋 장비 정보
    var item_equipment_preset_2: [EquipmentVO] = []
    /// 3번 프리셋 장비 정보
    var item_equipment_preset_3: [EquipmentVO] = []
    /// 칭호 정보
    var title: EquipmentTitleVO = .init()
    /// 에반 드래곤 장비 정보(에반인 경우)
    var dragon_equipment: [EquipmentVO] = []
    /// 메카닉 장비 정보(메카닉인 경우)
    var mechanic_equipment: [EquipmentVO] = []
}

/// 장비 정보
struct EquipmentVO: Codable, Hashable {
    /// 장비 부위 명
    @FallbackDecoding<EmptyString>
    var item_equipment_part: String = ""
    /// 장비 슬롯 위치
    @FallbackDecoding<EmptyString>
    var item_equipment_slot: String = ""
    /// 장비 명
    @FallbackDecoding<EmptyString>
    var item_name: String = ""
    /// 장비 아이콘
    @FallbackDecoding<EmptyString>
    var item_icon: String = ""
    /// 장비 설명
    @FallbackDecoding<EmptyString>
    var item_description: String = ""
    /// 장비 외형
    @FallbackDecoding<EmptyString>
    var item_shape_name: String = ""
    /// 장비 외형 아이콘
    @FallbackDecoding<EmptyString>
    var item_shape_icon: String = ""
    /// 전용 성별
    @FallbackDecoding<EmptyString>
    var item_gender: String = ""
    /// 장비 최종 옵션 정보
    var item_total_option: EquipmentOptionVO
    /// 장비 기본 옵션 정보
    var item_base_option: EquipmentOptionVO
    /// 잠재능력 등급
    @FallbackDecoding<EmptyString>
    var potential_option_grade: String = ""
    /// 에디셔널 잠재능력 등급
    @FallbackDecoding<EmptyString>
    var additional_potential_option_grade: String = ""
    /// 잠재능력 첫번째 옵션
    @FallbackDecoding<EmptyString>
    var potential_option_1: String = ""
    /// 잠재능력 두번쨰 옵션
    @FallbackDecoding<EmptyString>
    var potential_option_2: String = ""
    /// 잠재능력 세번째 옵션
    @FallbackDecoding<EmptyString>
    var potential_option_3: String = ""
    /// 에디셔널 잠재능력 첫번째 옵션
    @FallbackDecoding<EmptyString>
    var additional_potential_option_1: String = ""
    /// 에디셔널 잠재능력 두번째 옵션
    @FallbackDecoding<EmptyString>
    var additional_potential_option_2: String = ""
    /// 에디셔널 잠재능력 세번째 옵션
    @FallbackDecoding<EmptyString>
    var additional_potential_option_3: String = ""
    /// 착용 레벨 증가
    @FallbackDecoding<EmptyInt64>
    var equipment_level_increase: Int64 = 0
    /// 장비 특별 옵션 정보
    var item_exceptional_option: EquipmentOptionVO
    /// 장비 추가 옵션
    var item_add_option: EquipmentOptionVO
    /// 성장 경험치
    @FallbackDecoding<EmptyInt64>
    var growth_exp: Int64 = 0
    /// 성장 레벨
    @FallbackDecoding<EmptyInt64>
    var growth_level: Int64 = 0
    /// 업그레이드 횟수
    @FallbackDecoding<EmptyString>
    var scroll_upgrade: String = ""
    /// 가위 사용 횟수
    @FallbackDecoding<EmptyString>
    var cuttable_count: String = ""
    /// 황금 망치 제련 적용(1: 적용, 이외 미 적용)
    @FallbackDecoding<EmptyString>
    var golden_hammer_flag: String = ""
    /// 복구 가능 횟수
    @FallbackDecoding<EmptyString>
    var scroll_resilience_count: String = ""
    /// 업그레이드 가능 횟수
    @FallbackDecoding<EmptyString>
    var scroll_upgradeable_count: String = ""
    /// 소울명
    @FallbackDecoding<EmptyString>
    var soul_name: String = ""
    /// 소울 옵션
    @FallbackDecoding<EmptyString>
    var soul_option: String = ""
    /// 장비 기타 옵션 정보
    var item_etc_option: EquipmentOptionVO
    /// 스타포스 강화 단계
    @FallbackDecoding<EmptyString>
    var starforce: String = ""
    /// 놀라운 자입 강화 주문서 사용 여부(0: 미사용, 1: 사용)
    @FallbackDecoding<EmptyString>
    var starforce_scroll_flag: String = ""
    /// 장비 스타포스 옵션 정보
    var item_starforce_option: EquipmentOptionVO
    /// 특수 반지 레벨
    @FallbackDecoding<EmptyInt64>
    var special_ring_level: Int64 = 0
    /// 장비 유효 기간(KST)
    @FallbackDecoding<EmptyString>
    var date_expire: String = ""
}

/// 장비 옵션
struct EquipmentOptionVO: Codable, Hashable {
    /// 힘
    @FallbackDecoding<EmptyString>
    var str: String = ""
    /// 덱스
    @FallbackDecoding<EmptyString>
    var dex: String = ""
    /// 인트
    @FallbackDecoding<EmptyString>
    var int: String = ""
    /// 럭
    @FallbackDecoding<EmptyString>
    var luk: String = ""
    /// 최대 HP
    @FallbackDecoding<EmptyString>
    var max_hp: String = ""
    /// 최대 MP
    @FallbackDecoding<EmptyString>
    var max_mp: String = ""
    /// 공격력
    @FallbackDecoding<EmptyString>
    var attack_power: String = ""
    /// 마력
    @FallbackDecoding<EmptyString>
    var magic_power: String = ""
    /// 방어력
    @FallbackDecoding<EmptyString>
    var armor: String = ""
    /// 이동속도
    @FallbackDecoding<EmptyString>
    var speed: String = ""
    /// 점프력
    @FallbackDecoding<EmptyString>
    var jump: String = ""
    /// 보스 공격 시 데미지 증가(%)
    @FallbackDecoding<EmptyString>
    var boss_damage: String = ""
    /// 몬스터 방어율 무시(%)
    @FallbackDecoding<EmptyString>
    var ignore_monster_Armor: String = ""
    /// 올스탯(%)
    @FallbackDecoding<EmptyString>
    var all_stat: String = ""
    /// 데미지(%)
    @FallbackDecoding<EmptyString>
    var damage: String = ""
    /// 최대 HP(%)
    @FallbackDecoding<EmptyString>
    var max_hp_rate: String = ""
    /// 최대 MP(%)
    @FallbackDecoding<EmptyString>
    var max_mp_rate: String = ""
    /// 착용 레벨 감소
    @FallbackDecoding<EmptyInt64>
    var equipment_level_decrease: Int64 = 0
    /// 기본 착용 레벨
    @FallbackDecoding<EmptyInt64>
    var base_equipment_level: Int64 = 0
}

/// 칭호 정보
struct EquipmentTitleVO: Codable, Hashable {
    /// 칭호 장비 명
    @FallbackDecoding<EmptyString>
    var title_name: String = ""
    /// 칭호 아이콘
    @FallbackDecoding<EmptyString>
    var title_icon: String = ""
    /// 칭호 설명
    @FallbackDecoding<EmptyString>
    var title_description: String = ""
    /// 칭호 유효 기간(KST)
    @FallbackDecoding<EmptyString>
    var date_expire: String = ""
    /// 칭호 옵션 유효 기간(expired: 만료, null: 무제한)(KST)
    @FallbackDecoding<EmptyString>
    var date_option_expire: String = ""
}
