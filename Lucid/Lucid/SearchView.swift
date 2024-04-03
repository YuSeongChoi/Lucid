//
//  SearchView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI
import CoreData

struct SearchView: View {
    
    @AppStorage("ocid") private var ocid: String = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Basic.character_name, ascending: false)])
    private var basics: FetchedResults<Basic>
    
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
                                self.ocid = viewModel.ocid
                                try await viewModel.requestBasicInfo()
                                try await viewModel.requestDetailInfo()
                                saveContext()
                            } catch {
                                print(error.localizedDescription)
                            }
                        })
                    }
                    .buttonStyle(.purple)
                }
                
                VStack {
                    Text(viewModel.basicInfo.character_name)
                    if let url = URL(string: viewModel.basicInfo.character_image) {
                        AsyncImage(url: url)
                    }
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
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context : \(error)")
        }
    }
    
    func addBasicInfo(info: CharacterBasicVO) {
        let newBasic = Basic(context: managedObjectContext)
        
        newBasic.date = info.date
        newBasic.character_name = info.character_name
        newBasic.world_name = info.world_name
        newBasic.character_gender = info.character_gender
        newBasic.character_class = info.character_class
        newBasic.character_class_level = info.character_class_level
        newBasic.character_level = info.character_level
        newBasic.character_exp = info.character_exp
        newBasic.character_exp_rate = info.character_exp_rate
        newBasic.character_guild_name = info.character_guild_name
        newBasic.character_image = info.character_image
        
        saveContext()
    }
    
    func deleteBasicInfo(at offsets: IndexSet) {
        offsets.forEach { index in
            let basic = self.basics[index]
            self.managedObjectContext.delete(basic)
        }
        
        saveContext()
    }
    
}

#Preview {
    SearchView()
}
