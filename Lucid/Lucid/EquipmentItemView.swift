//
//  EquipmentItemView.swift
//  Lucid
//
//  Created by YuSeongChoi on 8/14/24.
//

import SwiftUI

struct EquipmentItemView: View {
    
    @AppStorage("ocid") private var ocid: String = ""
    @StateObject private var viewModel = EquipmentItemViewModel()
    let characterInfo: CharacterBasicVO
    let characterDetailInfo: CharacterDetailVO
    let itemInfo: CharacterItemEquipmentVO
    
    var body: some View {
        ScrollView {
            VStack {
                equipmentItemView
            }
            .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 22))
        }
        .task {
            do {
                // 유니온 정보 조회
                try await viewModel.requestUnionInfo(ocid: self.ocid)
                // 인기도 정보 조회
                try await viewModel.requestPopularityInfo(ocid: self.ocid)
                // 랭킹 조회(전체 및 서버)
                let world_type = characterInfo.world_name.contains("리부트") ? 1 : 0
                viewModel.totalRanking = try await viewModel.requestOverallRankingInfo(ocid: self.ocid, world_name: "", world_type: world_type)
                viewModel.serverRanking = try await viewModel.requestOverallRankingInfo(ocid: self.ocid, world_name: characterInfo.world_name, world_type: world_type)
                // 무릉도장 정보 조회
                try await viewModel.requestDojangBestRecordInfo(ocid: self.ocid)
            } catch {
                print(error.localizedDescription)
            }
        }
        .onDisappear {
            viewModel.taskStorage.forEach{ $0.cancel() }
            viewModel.taskStorage = []
        }
    }
    
    // MARK: 장비 아이템 뷰
    @ViewBuilder
    private var equipmentItemView: some View {
        HStack {
            Text("캐릭터 정보")
                .font(R.font.pretendardSemiBold.swiftFontOfSize(14))
            Spacer()
        }
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                if let url = URL(string: characterInfo.character_image) {
                    AsyncImage(url: url)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(characterInfo.character_name)
                        .pretendSemiBold(size: 13)
                    
                    HStack(spacing: 3) {
                        Text(characterInfo.world_name)
                        
                        Text(characterInfo.character_guild_name)
                    }
                    .pretendReg(size: 13)
                    
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(spacing: 3) {
                            Text(itemInfo.character_class)
                            Text("\(characterInfo.character_level)")
                            Text("\(characterInfo.character_exp_rate)%")
                        }
                        
                        HStack(spacing: 3) {
                            Text("유니온 \(viewModel.unionInfo.union_level)")
                            Text("인기도 \(viewModel.characterPopularity)")
                        }
                        
                        HStack(spacing: 3) {
                            Text("종합 \(viewModel.totalRanking)위")
                            Text("월드 \(viewModel.serverRanking)위")
                        }
                        
                        HStack(spacing: 3) {
                            Text("무릉 \(viewModel.dojangBestRecord)층")
//                            characterDetailInfo.final_stat.map { stat in
//                                if stat.stat_name == "전투력" {
//                                    return stat.stat_value
//                                }
//                            }
                            Text("전투력 \(characterDetailInfo.final_stat.filter{ $0.stat_name == "전투력"}.first?.stat_value ?? "0".formattedDecimalString())")
                            Spacer()
                        }
                    }
                    .pretendReg(size: 11)
                }
                
                Spacer()
            }
            
            ForEach(itemInfo.item_equipment, id: \.self) { item in
                HStack {
                    Text(item.item_equipment_slot)
                    Text(item.item_equipment_part)
                    
                    if let url = URL(string: item.item_icon) {
                        AsyncImage(url: url)
                    }
                }
            }
        }
    }
    
}
