//
//  Auth.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct Auth: Codable {
    let userType, accessToken, tokenType, expiresAt: String?

    enum CodingKeys: String, CodingKey {
        case userType
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresAt = "expires_at"
    }
}


struct AuthFiler: Codable {
    let success: Bool?
    let data: DataClass?
}


struct DataClass: Codable {
    let email, phone: [String]?
}
