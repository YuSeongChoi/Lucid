//
//  EquipmentItemView.swift
//  Lucid
//
//  Created by YuSeongChoi on 8/14/24.
//

import SwiftUI

struct EquipmentItemView: View {
    let itemInfo: CharacterItemEquipmentVO
    
    var body: some View {
        VStack {
            equipmentItemView
        }
        .padding(EdgeInsets(top: 15, leading: 22, bottom: 15, trailing: 22))
        .onAppear {
            print("item : \(itemInfo.item_equipment.count)")
        }
    }
    
    // MARK: 장비 아이템 뷰
    @ViewBuilder
    private var equipmentItemView: some View {    
        VStack(spacing: 10) {
            Text("장비 아이템 뷰!")
            
            ForEach(itemInfo.item_equipment, id: \.self) { item in
                HStack {
                    Text(item.item_equipment_slot)
                    Text(item.item_equipment_part)
                    if let url = URL(string: item.item_icon) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .progressViewStyle(.circular)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            case .failure(_):
                                EmptyView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
        }
    }
    
}
