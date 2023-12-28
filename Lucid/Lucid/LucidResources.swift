//
//  LucidResources.swift
//  Lucid
//
//  Created by YuSeongChoi on 12/28/23.
//

import Foundation
import CoreText

import RswiftResources

typealias LucidResourcesFont = _R.font

extension LucidResourcesFont {
    
    static func register() throws {
        let filteredFonts = R.font.filter{ $0.canBeLoaded() }
        guard !filteredFonts.isEmpty else { return }
        var errorArray = [Error]()
        errorArray.reserveCapacity(filteredFonts.count)
        let fontURLs: [URL] = filteredFonts.compactMap {
            guard let url = $0.bundle.url(forResource: $0.filename, withExtension: nil) else {
                errorArray.append(
                    CocoaError(
                        .fileNoSuchFile,
                        userInfo: [
                            NSLocalizedDescriptionKey : "\($0.filename)을 찾을 수 없습니다. \($0.bundle.bundlePath)에 해당 파일이 존재하지 않습니다."
                        ]
                    )
                )
                return nil
            }
            return url
        }
        let sema = DispatchSemaphore(value: 0)
        CTFontManagerRegisterFontURLs(fontURLs as CFArray, .process, false) { errors, done in
            print(errors)
            if (done) {
                errorArray.append(contentsOf: errors as! [CFError])
                sema.signal()
            }
            return true
        }
        sema.wait()
        if let error = errorArray.randomElement() {
            throw error
        }
    }
    
}
