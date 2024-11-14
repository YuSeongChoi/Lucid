//
//  HTTPClient.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation
import os

import Alamofire

extension Session {
    static var newInstance: Session {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 30
        
//        let eventLogger = APIEventLogger()
        let eventMonitors: [EventMonitor] = [DataMonitor(), AlertEventMonitor()]
        let session = Session(configuration: config, cachedResponseHandler: ResponseCacher.cache, eventMonitors: eventMonitors)
        
        return session
    }
    
    static let HTTPclient: Session = .newInstance
}

struct APIEventLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "NetworkLogger")
    
    // request가 끝났을 때 호출, 파라미터 request에 접근하여 header, body, method 등을 확인할 수 있다.
    func requestDidFinish(_ request: Request) {
        print("----------------------------------------------------\n\n" + "              🛰 NETWORK Reqeust LOG\n" + "\n----------------------------------------------------")
                print("1️⃣ URL / Method / Header" + "\n" + "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
                      + "Method: " + (request.request?.httpMethod ?? "") + "\n"
                      + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])")
                print("----------------------------------------------------\n2️⃣ Body")

        if let body = request.request?.httpBody, !body.isEmpty {
            print("Body: \(String(decoding: body, as: UTF8.self))")
        } else { print("보낸 Body가 없습니다.")}
        print("----------------------------------------------------\n")
    }

//     response가 오면 호출, response의 결과에 따라 통신 결과를 요약해서 확인할 수 있다.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("              🛰 NETWORK Response LOG")
        print("\n----------------------------------------------------")

        switch response.result {
        case .success(_):
            print("3️⃣ 서버 연결 성공")
        case .failure(_):
            print("3️⃣ 서버 연결 실패")
            print("올바른 URL인지 확인해보세요.")
        }

        print("Result: " + "\(response.result)" + "\n" + "StatusCode: " + "\(response.response?.statusCode ?? 0)")

        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400..<500:
                print("❗오류 발생 : RequestError\n" + "잘못된 요청입니다. request를 재작성 해주세요.")
            case 500:
                print("❗오류 발생 : ServerError\n" + "Server에 문제가 발생했습니다.")
            default:
                break
            }
        }

        print("----------------------------------------------------")
        print("4️⃣ Data 확인하기")
        if let response = response.data?.toPrettyPrintedString {
            print(response)
        } else {
            print("❗데이터가 없거나, Encoding에 실패했습니다.")
        }
        print("----------------------------------------------------")
    }
    
    func request(_ request: Request, didFailTask task: URLSessionTask, earlyWithError error: AFError) {
        print("URLSessionTask가 Fail 했습니다.")
    }
    
    func request(_ request: Request, didFailToCreateURLRequestWithError error: AFError) {
        print("URLRequest를 만들지 못했습니다.")
    }
    
    func requestDidCancel(_ request: Request) {
        print("request가 cancel 되었습니다.")
    }
    
}

struct AlertEventMonitor: EventMonitor {
    
    var queue: DispatchQueue { .global(qos: .userInitiated) }
    
    func requestDidFinish(_ request: Request) {
        guard let error = request.error, !error.isExplicitlyCancelledError else {
            return
        }
        if let dataRequest = request as? DataRequest, let data = dataRequest.data {
            processErrorData(data, fallbackError: error)
        } else {
            postDefaultError(error)
        }
    }
    
    func request<Value>(_ request: DataStreamRequest, didParseStream response: DataResponse<Value, AFError>) {
        guard let error = response.error,
              case .responseSerializationFailed = error else {
            return
        }
        if let data = response.data {
            processErrorData(data, fallbackError: error)
        }
    }
    
    private func processErrorData(_ data: Data, fallbackError: Error?) {
        // JSON 디코딩
        if let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
            let errorMessage: String
            switch apiError.error.name {
            case "OPENAPI00001":
                errorMessage = NexonAPIErrorMessage.OPENAPI00001.errorDescription
            case "OPENAPI00002":
                errorMessage = NexonAPIErrorMessage.OPENAPI00002.errorDescription
            case "OPENAPI00003":
                errorMessage = NexonAPIErrorMessage.OPENAPI00003.errorDescription
            case "OPENAPI00004":
                errorMessage = NexonAPIErrorMessage.OPENAPI00004.errorDescription
            case "OPENAPI00005":
                errorMessage = NexonAPIErrorMessage.OPENAPI00005.errorDescription
            case "OPENAPI00006":
                errorMessage = NexonAPIErrorMessage.OPENAPI00006.errorDescription
            case "OPENAPI00007":
                errorMessage = NexonAPIErrorMessage.OPENAPI00007.errorDescription
            case "OPENAPI00009":
                errorMessage = NexonAPIErrorMessage.OPENAPI00009.errorDescription
            case "OPENAPI00010":
                errorMessage = NexonAPIErrorMessage.OPENAPI00010.errorDescription
            case "OPENAPI00011":
                errorMessage = NexonAPIErrorMessage.OPENAPI00011.errorDescription
            default:
                errorMessage = apiError.error.message // 기본 메시지
            }
            
            let notification = Notification(
                name: WindowAlertHostingView.AlertNotificationName,
                object: ["errorMessage": errorMessage]
            )
            NotificationCenter.default.post(notification)
        } else {
            postDefaultError(fallbackError)
        }
    }
    
    private func postDefaultError(_ error: Error?) {
        let errorMessage = error?.localizedDescription ?? "알 수 없는 오류 발생"
        let notification = Notification(
            name: WindowAlertHostingView.AlertNotificationName,
            object: ["errorMessage" : errorMessage]
        )
        NotificationCenter.default.post(notification)
    }
    
}

struct DataMonitor: EventMonitor {
    
    let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier.unsafelyUnwrapped,
        category: "Alamofire"
    )
    let queue: DispatchQueue = .global(qos: .background)
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let result: Result<Data?, AFError>
        if let error = response.error {
            result = .failure(error)
        } else {
            result = .success(response.data)
        }
        let dataResponse = DataResponse(request: response.request, response: response.response, data: response.data, metrics: response.metrics, serializationDuration: response.serializationDuration, result: result)
        dataRequestDidParseResponse(request, didParseResponse: dataResponse)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        dataRequestDidParseResponse(request, didParseResponse: response)
    }
    
    private func dataRequestDidParseResponse(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        var debugDescription = response.debugDescription
        debugDescription = debugDescription.replacingOccurrences(of: "\n", with: "\n│ ")
            .replacingOccurrences(of: "(\\[Body]:)\\s*\n│", with: "[Body]:\n ", options: [.regularExpression])
        
        switch request {
        case let (uploadRequest as UploadRequest):
            switch uploadRequest.uploadable {
            case .none:
                break
            case .some(.data(_)):
//                let multipartString = String(decoding: uploadData, as: UTF8.self)
//                debugDescription = debugDescription.replacingOccurrences(of: "[Body]: None", with: "[Body]:\n\t\t\(multipartString)")
                break
            case .some(.file(_, shouldRemove: _)):
                break
            case .some(.stream(_)):
                break
            }
        default:
            if let requestData = response.request?.httpBody,
               !requestData.isEmpty,
               debugDescription.contains("[Body]: \(requestData)"),
               let contentType = response.request?.value(forHTTPHeaderField: "Content-Type"),
               contentType.lowercased().contains("charset=utf-8") {
                let requestBody = String(decoding: requestData, as: UTF8.self)
                debugDescription = debugDescription.replacingOccurrences(of: "[Body]: \(requestData)", with: "[Body]:\n\t\t\(requestBody)")
            }
        }
        
        logger.log(
            level: .debug,
            """
            ┌───────────────────────────────────────────────
            │ \(debugDescription)
            └───────────────────────────────────────────────
            """
        )
    }
    
}

final class NetworkAlert {
    
    @MainActor
    class func dismissNetworkAlert() {
        NotificationCenter.default.post(name: WindowAlertHostingView.AlertDismissNotificationName, object: nil)
    }
    
}
