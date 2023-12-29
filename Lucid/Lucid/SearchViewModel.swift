//
//  SearchViewModel.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation

import Alamofire

@MainActor
final class SearchViewModel: ObservableObject, Identifiable {
    
    @Published var ocid: String = ""
    var taskStorage: Set<Task<Void,Never>> = []
    
}

// MARK: - Request APIs
extension SearchViewModel {
    
    func requestCharacterID(name: String) async throws {
        do {
            let result = try await HTTPRequestList.CharacterIDRequest(character_name: name)
                .buildDataRequest()
                .serializingDecodable(CharacterIDVO.self, automaticallyCancelling: true)
                .result.mapError{ $0.underlyingError ?? $0 }
                .get()
            self.ocid = result.ocid
        } catch AFError.explicitlyCancelled {
            
        }
    }
    
}
