//
//  CustomStyle.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

import RswiftResources

struct PurpleConfirmButtonStyle: ButtonStyle {
    
    var width: CGFloat = .infinity
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .pretendBold(size: 18)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .frame(maxWidth: width)
            .background(Color.lightishPurple)
            .cornerRadius(10)
    }
    
}

extension ButtonStyle where Self == PurpleConfirmButtonStyle {
    internal static var purple: PurpleConfirmButtonStyle { return PurpleConfirmButtonStyle() }
}
