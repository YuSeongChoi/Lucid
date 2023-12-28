//
//  SwiftUIEnvironment.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import SwiftUI

struct ClearBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.presentationBackground(.clear)
        } else {
            content
                .background(SimpleViewRepresenter { _ in
                    let view = UIView()
                    DispatchQueue.main.async {
                        if let viewController = view.target(forAction: #selector(UIViewController.viewDidLoad), withSender: view) as? UIViewController {
                            viewController.view.backgroundColor = nil
                        }
                    }
                    return view
                })
        }
    }
}

extension View {
    func clearModalBackground() -> some View {
        modifier(ClearBackgroundViewModifier())
    }
}
