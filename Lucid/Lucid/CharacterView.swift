//
//  CharacterView.swift
//  Lucid
//
//  Created by YuSeongChoi on 2/11/25.
//

import SwiftUI

struct CharacterView: View {
    @AppStorage("ocid") private var ocid: String = ""
    @StateObject private var viewModel = EquipmentItemViewModel()
    @State private var selection: CharacterTabItem = .stat
    let characterInfo: CharacterBasicVO
    let characterDetailInfo: CharacterDetailVO
    let itemInfo: CharacterItemEquipmentVO
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                characterFixedInfoView
                characterHeaderView
                
                switch selection {
                case .stat:
                    Text("스탯")
                case .equipment:
                    EquipmentItemView(itemInfo: itemInfo)
                case .skill:
                    Text("스킬")
                case .record:
                    Text("기록")
                }
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
    
    // MARK: 캐릭터 기본 고정 정보뷰
    @ViewBuilder
    private var characterFixedInfoView: some View {
        VStack {
            HStack {
                Text("캐릭터 정보")
                    .pretendSemiBold(size: 16)
                Spacer()
            }
            
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
                            let power = characterDetailInfo.final_stat.filter{ $0.stat_name == "전투력"}.first?.stat_value
                            Text("무릉 \(viewModel.dojangBestRecord)층")
                            
                            if let powerStat = power {
                                Text("전투력 \(powerStat.formattedDecimalString())")
                            }
                            Spacer()
                        }
                    }
                    .pretendReg(size: 11)
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: 캐릭터 정보 탭뷰
    @ViewBuilder
    private var characterHeaderView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(CharacterTabItem.allCases, id: \.self) { tab in
                    Button {
                        withAnimation {
                            selection = tab
                        }
                    } label: {
                        if selection == tab {
                            Color.lightishPurple.overlay(
                                Text(tab.pogingTItle)
                            )
                        } else {
                            Color.lightishPurple.opacity(0.75).overlay(
                                Text(tab.pogingTItle)
                            )
                        }
                    }
                    .pretendBold(size: 12)
                    .foregroundStyle(.white)
                }
            }
        }
        .frame(height: 50)
        .cornerRadius(10)
    }
}

extension CharacterView {
    enum CharacterTabItem: String, CaseIterable {
        /// 스탯
        case stat
        /// 장비
        case equipment
        /// 스킬
        case skill
        /// 기록
        case record
        
        var pogingTItle: String {
            switch self {
            case .stat:
                return "스탯"
            case .equipment:
                return "장비"
            case .skill:
                return "스킬"
            case .record:
                return "기록"
            }
        }
    }
}

/// 내부 콘텐츠의 높이에 따라 TabView의 최소 높이를 조정하는 커스텀 뷰
struct HeightPreservingTabView<SelectionValue: Hashable, Content: View>: View {
    var selection: Binding<SelectionValue>?
    @ViewBuilder var content: () -> Content

    // 초기에는 1 이상의 값이 필요 (0이면 측정되지 않음)
    @State private var minHeight: CGFloat = 1

    var body: some View {
        TabView(selection: selection) {
            content()
                .background(
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: TabViewMinHeightPreference.self,
                            value: geometry.frame(in: .local).height
                        )
                    }
                )
        }
        .frame(minHeight: minHeight)
        .onPreferenceChange(TabViewMinHeightPreference.self) { newHeight in
            self.minHeight = newHeight
        }
    }
}

/// PreferenceKey를 사용해 최대 높이를 결정
private struct TabViewMinHeightPreference: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
