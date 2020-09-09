//
//  orderMessage.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct orderMessage: Codable {
    let success: Bool?
    let message: String?
    let data: orderDatas?
}

struct orderDatas: Codable {
    let msg: String?
}
