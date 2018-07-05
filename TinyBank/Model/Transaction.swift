//
//  Transaction.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let identifier: String
    let description: String
    let categoryIdentifier: Category
    let currency: String
    let amount: Amount
    let product: Product

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case categoryIdentifier = "category_id"
        case description, currency, amount, product
    }
}

enum Category: Int, Codable {
    case general = 0
    case bills = 1
    case food = 5
    case entertainment = 6
    case groceries = 7

    var description: String {
        switch self {
        case .general:
            return "General"
        case .bills:
            return "Bills"
        case .food:
            return "Food & Drink"
        case .entertainment:
            return "Entertainment"
        case .groceries:
            return "Groceries"
        default:
            return "Unknown"
        }
    }
}
