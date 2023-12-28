//
//  CommonUseView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

import RswiftResources

struct CommonTextField: View {
    
    var placeHolder: String
    var keyboard: UIKeyboardType = .default
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text, prompt: Text(placeHolder).foregroundColor(.RGB_157))
            .pretendBold(size: 18)
            .keyboardType(keyboard)
            .padding(EdgeInsets(top: 14, leading: 18, bottom: 14, trailing: 18))
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.RGB_205)
            )
    }
    
}
