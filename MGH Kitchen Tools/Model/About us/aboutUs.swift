//
//  aboutUs.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct aboutUs: Codable {
    let success: Bool?
    let data: aboutUsData?
    let message: String?
}


struct aboutUsData: Codable {
    let id: Int?
    let pageName: String?
    let image: String?
    let title, dataDescription, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, pageName, image, title
        case dataDescription = "description"
        case createdAt = "created_at"
    }
}
