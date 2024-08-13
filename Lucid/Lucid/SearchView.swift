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
    
    @State private var selectedItem: EquipmentVO? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                searchTextFieldView
                searchResultView
                equipmentItemView
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 1)
        .sheet(item: $selectedItem) { item in
            Text(item.item_name)
        }
        .onDisappear {
            viewModel.taskStorage.forEach{ $0.cancel() }
            viewModel.taskStorage = []
        }
    }
    
    // MARK: 검색 텍스트필드 뷰
    @ViewBuilder
    private var searchTextFieldView: some View {
        VStack(spacing: 20) {
            CommonTextField(placeHolder: "캐릭터명 입력", text: $searchName)

            Button("검색") {
                viewModel.taskStorage.insert(Task {
                    do {
                        try await viewModel.requestCharacterID(name: searchName)
                        self.ocid = viewModel.ocid
                        viewModel.basicInfo = try await viewModel.requestBasicInfo()
                        try await viewModel.requestUnionRankingInfo()
                        try await viewModel.requestEquipmentItemInfo(ocid: self.ocid)
                        
//                                try await viewModel.requestUnionRaiderInfo()
//                                try await viewModel.requestDetailInfo()
//                                saveContext()
                    } catch {
                        print(error.localizedDescription)
                    }
                })
            }
            .buttonStyle(.purple)
        }
    }
        
    // MARK: 검색결과 뷰
    @ViewBuilder
    private var searchResultView: some View {
        VStack(spacing: 30) {
            VStack(spacing: 15) {
                       Text(viewModel.basicInfo.character_name)
                    .font(R.font.pretendardRegular.swiftFontOfSize(13))
                if let url = URL(string: viewModel.basicInfo.character_image) {
                    AsyncImage(url: url)
                }
            }
            
            VStack(spacing: 15) {
                if !viewModel.mainCharacterInfo.character_name.isEmpty {
                    Text("본캐")
                        .font(R.font.pretendardSemiBold.swiftFontOfSize(16))
                    Text(viewModel.mainCharacterInfo.character_name)
                        .font(R.font.pretendardRegular.swiftFontOfSize(13))
                    if let url = URL(string: viewModel.mainCharacterInfo.character_image) {
                        AsyncImage(url: url)
                    }
                }
            }
        }
    }
    
    // MARK: 장비 아이템 뷰
    @ViewBuilder
    private var equipmentItemView: some View {
        if !viewModel.basicInfo.character_name.isEmpty {
            HStack {
                Text("캐릭터 정보")
                    .font(R.font.pretendardSemiBold.swiftFontOfSize(14))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.basicInfo.character_name)
                    .font(R.font.pretendardRegular.swiftFontOfSize(13))
                
                HStack(spacing: 15) {
                    if let url = URL(string: viewModel.basicInfo.character_image) {
                        AsyncImage(url: url)
                    }
                    Text(viewModel.equipmentItemInfo.character_class)
                        .font(R.font.pretendardRegular.swiftFontOfSize(13))
                    Spacer()
                }
                
                ForEach(viewModel.equipmentItemInfo.item_equipment, id: \.self) { item in
                    HStack {
                        Text(item.item_equipment_slot)
                        
                        if let url = URL(string: item.item_icon) {
                            AsyncImage(url: url)
                        }
                    }
                    .onTapGesture {
                        selectedItem = item
                    }
                }
            }
        }
    }
    
}

// MARK: - CoreData 관련
extension SearchView {
    
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
