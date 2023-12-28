//
//  SearchView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchName: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("", text: $searchName, prompt: Text("캐릭터명 입력"))
                }
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SearchView()
}
