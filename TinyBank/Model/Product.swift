//
//  Product.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import Foundation

struct Product: Codable {

    let identifier: Double
    let title: String
    private let icon: String

    var imageURL: URL? {
        return URL(string: icon)
    }

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title, icon
    }
}
