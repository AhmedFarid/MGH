//
//  categories.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct categories: Codable {
       let success: Bool?
        let data: dataCategories?
        let message: String?
    }


    struct dataCategories: Codable {
        let data: [dataCategoriesArray]?
        let meta: metaCategories?
    }

    struct dataCategoriesArray: Codable {
        let id: Int?
           let name: String?
           let subcategories: [dataCategoriesArray]?
           let image: String?
           let categoryid: Int?
        
        enum CodingKeys: String, CodingKey {
               case id, name, subcategories, image
               case categoryid = "category_id"
           }
    }

    struct metaCategories: Codable {
        let currentPage, lastPage, perPage: Int?
        let hasMorePages: Bool?
        let total: Int?

        enum CodingKeys: String, CodingKey {
            case currentPage = "current_page"
            case lastPage = "last_page"
            case perPage = "per_page"
            case hasMorePages, total
        }
    }
