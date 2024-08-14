//
//  EquipmentItemView.swift
//  Lucid
//
//  Created by YuSeongChoi on 8/14/24.
//

import SwiftUI

struct EquipmentItemView: View {
    
    let characterInfo: CharacterBasicVO
    let itemInfo: CharacterItemEquipmentVO
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                equipmentItemView
            }
            .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 22))
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
            HStack(spacing: 15) {
                if let url = URL(string: characterInfo.character_image) {
                    AsyncImage(url: url)
                }
                VStack(spacing: 10) {
                    Text(itemInfo.character_class)
                        .font(R.font.pretendardRegular.swiftFontOfSize(13))
                    Text(characterInfo.character_name)
                        .font(R.font.pretendardRegular.swiftFontOfSize(13))
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
