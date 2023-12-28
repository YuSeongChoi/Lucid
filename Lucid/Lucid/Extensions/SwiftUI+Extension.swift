//
//  SwiftUI+Extension.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

import RswiftResources

extension Text {
    
    func NotoSansReg(size: CGFloat) -> Text {
        self.font(R.font.notoSansCJKkrRegular.swiftFontOfSize(size))
    }
    
    func NotoSansMid(size: CGFloat) -> Text {
        self.font(R.font.notoSansCJKkrMedium.swiftFontOfSize(size))
    }
    
    func NotoSansBold(size: CGFloat) -> Text {
        self.font(R.font.notoSansCJKkrBold.swiftFontOfSize(size))
    }
    
    func LatoReg(size: CGFloat) -> Text {
        self.font(R.font.latoRegular.swiftFontOfSize(size))
    }
    
    func LatoBold(size: CGFloat) -> Text {
        self.font(R.font.latoBold.swiftFontOfSize(size))
    }
    
    func pretendBold(size: CGFloat, tracking: CGFloat = 0.5) -> Text {
        self.font(R.font.pretendardBold.swiftFontOfSize(size)).tracking(tracking)
    }
    
    func pretendSemiBold(size: CGFloat, tracking: CGFloat = 0.5) -> Text {
        self.font(R.font.pretendardSemiBold.swiftFontOfSize(size)).tracking(tracking)
    }
    
    func pretendMid(size: CGFloat, tracking: CGFloat = 0.5) -> Text {
        self.font(R.font.pretendardMedium.swiftFontOfSize(size)).tracking(tracking)
    }
    
    func pretendReg(size: CGFloat, tracking: CGFloat = 0.5) -> Text {
        self.font(R.font.pretendardRegular.swiftFontOfSize(size)).tracking(tracking)
    }
    
}

extension View {
    
    func NotoSansReg(size: CGFloat) -> some View {
        self.font(R.font.notoSansCJKkrRegular.swiftFontOfSize(size))
    }
    
    func NotoSansMid(size: CGFloat) -> some View {
        self.font(R.font.notoSansCJKkrMedium.swiftFontOfSize(size))
    }
    
    func NotoSansBold(size: CGFloat) -> some View {
        self.font(R.font.notoSansCJKkrBold.swiftFontOfSize(size))
    }
    
    func LatoReg(size: CGFloat) -> some View {
        self.font(R.font.latoRegular.swiftFontOfSize(size))
    }
    
    func LatoBold(size: CGFloat) -> some View {
        self.font(R.font.latoBold.swiftFontOfSize(size))
    }
    
    func pretendSemiBold(size: CGFloat) -> some View {
        self.font(R.font.pretendardSemiBold.swiftFontOfSize(size))
    }
    
    func pretendBold(size: CGFloat) -> some View {
        self.font(R.font.pretendardBold.swiftFontOfSize(size))
    }
    
    func pretendMid(size: CGFloat) -> some View {
        self.font(R.font.pretendardMedium.swiftFontOfSize(size))
    }
    
    func pretendReg(size: CGFloat) -> some View {
        self.font(R.font.pretendardRegular.swiftFontOfSize(size))
    }
    
}
