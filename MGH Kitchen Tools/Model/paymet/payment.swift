//
//  payment.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct payment: Codable {
    let success: Bool?
    let data: paymentData?
    let message: String?
}

struct paymentData: Codable {
    let link: String?
}
