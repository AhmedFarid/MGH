//
//  deliveries.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct deliveries: Codable {
    let success: Bool?
    let data: [deliveriesData]?
    let message: String?
}

struct deliveriesData: Codable {
    let id, fastPrice, slowPrice: Int?
    let city: City?

    enum CodingKeys: String, CodingKey {
        case id
        case fastPrice = "fast_price"
        case slowPrice = "slow_price"
        case city
    }
}

struct City: Codable {
    let id: Int?
    let name: String?
}

struct deliveri: Codable {
    let data: [deliveryPrices]?
}

struct deliveryPrices: Codable {
    let price: Int?
    let vlaue: String?
}
