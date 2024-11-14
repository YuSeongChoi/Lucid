//
//  ErrorMessage.swift
//  Lucid
//
//  Created by YuSeongChoi on 11/14/24.
//

import Foundation

enum NexonAPIErrorMessage: String {
    /// 넥슨 서버 오류
    case OPENAPI00001
    /// 권한 오류
    case OPENAPI00002
    /// 식별자 오류
    case OPENAPI00003
    /// 파라미터 오류
    case OPENAPI00004
    /// API KEY 오류
    case OPENAPI00005
    /// API PATH 오류
    case OPENAPI00006
    /// 호출량 초과
    case OPENAPI00007
    /// 데이터 준비중
    case OPENAPI00009
    /// 게임 점검중
    case OPENAPI00010
    /// API 서버 점검중
    case OPENAPI00011
    
    var errorDescription: String {
        switch self {
        case .OPENAPI00001: 
            return "넥슨 서버 내부 오류"
        case .OPENAPI00002:
            return "권한이 없습니다."
        case .OPENAPI00003:
            return "유효하지 않은 식별자입니다."
        case .OPENAPI00004:
            return "유효하지 않은 파라미터입니다."
        case .OPENAPI00005:
            return "유효하지 않은 API KEY입니다."
        case .OPENAPI00006:
            return "유효하지 않은 게임 또는 API PATH입니다."
        case .OPENAPI00007:
            return "API 호출량이 초과되었습니다."
        case .OPENAPI00009:
            return "데이터를 준비중입니다."
        case .OPENAPI00010:
            return "게임 점검 중입니다."
        case .OPENAPI00011:
            return "API 점검 중입니다."
        }
    }
}
