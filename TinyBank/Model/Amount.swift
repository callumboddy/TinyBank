//
//  Amount.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import Foundation

struct Amount: Codable {
    let value: Double
    let currencyISO: String

    enum CodingKeys: String, CodingKey {
        case currencyISO = "currency_iso"
        case value
    }
}
