//
//  gifts.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct gifts: Codable {
    let success: Bool?
    let data: [giftsData]?
    let message: String?
}

struct giftsData: Codable {
    let id: Int?
    let type, title, giftValue: String?

    enum CodingKeys: String, CodingKey {
        case id, type, title
        case giftValue = "gift_value"
    }
}
