//
//  message.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct Messages: Codable {
    let success: Bool?
    let data, message: String?
}


struct promCodeError: Codable {
    let success: Bool?
    let data: datapromCodeError?
}


struct datapromCodeError: Codable {
    let code: [String]?
}



struct promCodeSucces: Codable {
    let success: Bool?
    let data: DataPromCodeSucces?
    let message: String?
}


struct DataPromCodeSucces: Codable {
    let discount: Int?
}
