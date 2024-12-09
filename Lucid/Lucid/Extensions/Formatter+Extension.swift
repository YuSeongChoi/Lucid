//
//  Formatter+Extension.swift
//  Lucid
//
//  Created by YuSeongChoi on 11/14/24.
//

import Foundation

extension String {
    func formattedDecimalString() -> String {
        guard let number = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
}

