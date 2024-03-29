//
//  profile.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct profile: Codable {
    let success: Bool?
    let data: profileData?
    let message: String?
}

struct profileData: Codable {
    let fullName, email, phone: String?
    let image,giftType,giftValue: String?
    let firebaseToken, status, gender, promocode: String?
    let isGiftUsed, createdAt: String?
    let giftId: Int?
    let PromocodeAvailability: String?
    let points,notes: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, phone, image, firebaseToken, status, gender, promocode
        case isGiftUsed = "is_gift_used"
        case createdAt = "created_at"
        case giftId = "gift_id"
        case giftType = "gift_type"
        case giftValue = "gift_value"
        case PromocodeAvailability = "Promocode_availability"
        case points
        case notes
    }
}
