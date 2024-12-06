//
//  Formatter+Extension.swift
//  Lucid
//
//  Created by YuSeongChoi on 11/14/24.
//

import Foundation

extension String {
    func formattedDecimalString() -> String {
        print("LCK 1 \(self)")
        guard let number = Double(self) else { return self }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        print("LCK 2 \(number)")
        return formatter.string(from: NSNumber(value: number)) ?? self
    }
}

