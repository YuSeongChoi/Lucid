//
//  HTTPRequestProtocol.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import Alamofire


protocol RequestFormProtocol: URLRequestConvertible {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension RequestFormProtocol {
    
    var base: String { ServerConstant.baseURL }
    var baseRequest: URLRequest {
        get throws {
            let url = try base.asURL().appendingPathComponent(path)
            var request = URLRequest(url: url)
            var headers: HTTPHeaders = [:]
            let key = API_KEY.replacingOccurrences(of: "\"", with: "")
            headers["Content-Type"] = "application/json;charset=UTF-8"
            headers["x-nxopen-api-key"] = key
            request.headers = headers
            request.method = method
            return request
        }
    }
    
}

extension RequestFormProtocol {
    
    func asURLRequest() throws -> URLRequest {
        try baseRequest
    }
    
}

protocol DataRequestFormProtocol: RequestFormProtocol, Sendable {
    var encoder: ParameterEncoder { get }
    var validation: DataRequest.Validation? { get }
    func buildDataRequest(_ interceptor: RequestInterceptor?) -> DataRequest
}

extension DataRequestFormProtocol {
    
    var encoder: ParameterEncoder {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = "yyyyMMdd"
        let URLEncoder = URLEncodedFormEncoder(arrayEncoding: .noBrackets, dateEncoding: .formatted(formatter))
        return URLEncodedFormParameterEncoder(encoder: URLEncoder)
    }
    
    func buildDataRequest(_ interceptor: RequestInterceptor? = nil) -> DataRequest {
        let request = Session.HTTPclient.request(self, interceptor: interceptor).validate()
        if let validator = validation {
            return request.validate(validator)
        } else {
            return request
        }
    }
    
    @Sendable
    func performRequest(_ interceptor: RequestInterceptor? = nil) async throws -> Data {
        let request = Session.HTTPclient.request(self, interceptor: interceptor).validate()
        return try await request
            .validate()
            .serializingResponse(using: .string, automaticallyCancelling: true)
            .response.map{ Data($0.utf8) }.result
            .mapError{ $0.underlyingError ?? $0 }.get()
    }
    
}

extension DataRequestFormProtocol where Self: Encodable {
    
    func asURLRequest() throws -> URLRequest {
        try encoder.encode(self, into: baseRequest)
    }
    
}

public struct ValidationError: Error {
    
    var message: String?
    
//    static var messageValidation: DataRequest.Validation {
//        { _, response, data in
//            print("LCK 1")
//            guard let data = data else {
//                return .success(())
//            }
//            print("LCK 2")
//            guard (200..<300).contains(response.statusCode) else {
//                return .success(())
//            }
//            print("LCK 3")
//            let error = try? JSONDecoder().decode(ErrorVO.self, from: data)
//            return .failure(ValidationError(message: error?.message))
//        }
//    }
    
}

/// this Procotols network Error will be  not handled by the EventMonitor
public protocol URLRequestManagedErrorProtocol: URLRequestConvertible {}

public protocol PrefetchRequestProtocol: URLRequestConvertible {}
