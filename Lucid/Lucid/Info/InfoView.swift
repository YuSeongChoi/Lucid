//
//  InfoView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct InfoView: View {
    
    @AppStorage("ocid") private var ocid: String = ""
    
    var body: some View {
        Text("Info")
    }
    
}
