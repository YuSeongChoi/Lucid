//
//  SearchView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchName: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    CommonTextField(placeHolder: "캐릭터명 입력", text: $searchName)
                    
                    Button("검색") {
                        viewModel.taskStorage.insert(Task {
                            do {
                                try await viewModel.requestCharacterID(name: searchName)
                            } catch {
                                print(error.localizedDescription)
                            }
                        })
                    }
                    .buttonStyle(.purple)
                }
                
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 1)
        .onDisappear {
            viewModel.taskStorage.forEach{ $0.cancel() }
            viewModel.taskStorage = []
        }
    }
}

#Preview {
    SearchView()
}
