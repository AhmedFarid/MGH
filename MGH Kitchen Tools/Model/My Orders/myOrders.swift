//
//  myOrders.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct myOrders: Codable {
    let success: Bool?
    let data: [myOrdersData]?
    let message: String?
}


struct myOrdersData: Codable {
    let id: Int?
    let status: String?
    let total: Int?
    let customerName, customerAddress, customerPhone, customerCity: String?
    let customerRegion, customerStreet, customerHomeNumber, customerFloorNumber: String?
    let paymentMethod, paymentStatus, promocode: String?
    let promocodeValue: Int?
    let orderDetails: [productsDataArray]?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
       case id, status, total
        case customerName = "customer_name"
        case customerAddress = "customer_address"
        case customerPhone = "customer_phone"
        case customerCity = "customer_city"
        case customerRegion = "customer_region"
        case customerStreet = "customer_street"
        case customerHomeNumber = "customer_home_number"
        case customerFloorNumber = "customer_floor_number"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case promocode
        case promocodeValue = "promocode_value"
        case orderDetails
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
