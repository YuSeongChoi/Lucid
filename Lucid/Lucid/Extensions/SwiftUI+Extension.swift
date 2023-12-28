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

extension View {
    
    ///bool타입 공용 팝업
    func presentationPopupView<Content:View>(isPresented:Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .fullScreenCover(isPresented: isPresented) {
                    ZStack(alignment: .bottom) {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    isPresented.wrappedValue.toggle()
                                }
                            }
                        content()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clearModalBackground()
                    .ignoresSafeArea()
            }
    }
    
    ///Identifiable타입 공용 팝업
    func presentationPopupView<Content:View,Item:Identifiable>(item:Binding<Item?>, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self
            .fullScreenCover(item:item) { type in
                VStack {
                    Spacer()
                    content(type)
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color.black.opacity(0.5).ignoresSafeArea().onTapGesture { item.wrappedValue = nil })
                    .clearModalBackground()
                    .ignoresSafeArea()
            }
    }
    
    func presentationAlertView<Content:View>(isPresented:Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .fullScreenCover(isPresented: isPresented) {
                    VStack {
                        content()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5).ignoresSafeArea())
                    .clearModalBackground()
            }
    }
    
    ///Identifiable타입 공용 알림
    func presentationAlertView<Content:View,Item:Identifiable>(item:Binding<Item?>, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self
            .fullScreenCover(item:item) { type in
                VStack {
                    content(type)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5).ignoresSafeArea())
                .clearModalBackground()
            }
    }
    
}

#if canImport(UIKit)
extension View {
    ///키보드 숨기기
    @MainActor func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
