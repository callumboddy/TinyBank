//
//  PriceFormatter.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import Foundation

class PriceFormatter {
    static func format(value: Double, currencyISO: String) -> String? {

        // covnert price to NSNumber for use with NSNumberFormatter
        let price = NSNumber(value: value)

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyISO

        return formatter.string(from: price)
    }
}
