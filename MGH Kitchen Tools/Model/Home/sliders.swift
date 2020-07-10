//
//  sliders.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct sliders: Codable {
    let success: Bool?
    let data: [slidersData]?
    let message: String?
}


struct slidersData: Codable {
    let id: Int?
    let image: String?
    let title: String?
}
