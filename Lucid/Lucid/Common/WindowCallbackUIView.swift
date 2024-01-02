//
//  WindowCallbackUIView.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/29/23.
//

import UIKit

@MainActor
@usableFromInline
final class WindowCallbackUIView: UIView {
    
    @usableFromInline
    var callBack: ((UIWindowScene?) -> ())? = nil
    
    @inlinable
    override func didMoveToWindow() {
        super.didMoveToWindow()
        callBack?(window?.windowScene)
    }
    
    @inlinable
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        callBack?(newWindow?.windowScene)
    }
    
}
