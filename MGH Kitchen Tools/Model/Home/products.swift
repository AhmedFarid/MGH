//
//  products.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation

struct products: Codable {
    let success: Bool?
    let data: productsData?
    let message: String?
}


struct productsData: Codable {
    let data: [productsDataArray]?
    let meta: Meta?
}


struct productsDataArray: Codable {
    let id: Int?
    let status: String?
    let featured, trending, isNew, bestSeller: Bool?
    let off50, onSale, hotDeal: Bool?
    let hotDealPrice: Int?
    let expireDateHotDeal, productCode, porductSkuCode, productSerialNumber: String?
    let linkYoutube: String?
    let stock, stockLimitAlert, countSolid, numberViews: Int?
    let numberClicks, totalNumberReview: Int?
    let reviews: [Review]?
    let salePrice, discount, total: Int?
    let totalWithCurrency: String?
    let image: String?
    let category, subcategory, brand, createdBy: String?
    let updatedBy, name, shortDescription, datumDescription: String?
    let productImages: [ProductImage]?
    let productInCart, productInCartQty, productInCartTotal, isProductFavoirte: Int?
    let currency: String?
    let totalRate: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, status, featured, trending
        case isNew = "is_new"
        case bestSeller = "best_seller"
        case off50 = "off_50"
        case onSale = "on_sale"
        case hotDeal = "hot_deal"
        case hotDealPrice = "hot_deal_price"
        case expireDateHotDeal = "expire_date_hot_deal"
        case productCode = "product_code"
        case porductSkuCode = "porduct_sku_code"
        case productSerialNumber = "product_serial_number"
        case linkYoutube = "link_youtube"
        case stock
        case stockLimitAlert = "stock_limit_alert"
        case countSolid = "count_solid"
        case numberViews = "number_views"
        case numberClicks = "number_clicks"
        case totalRate = "total_rate"
        case totalNumberReview = "total_number_review"
        case reviews
        case salePrice = "sale_price"
        case discount, total
        case totalWithCurrency = "total_with_currency"
        case image, category, subcategory, brand
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case name
        case shortDescription = "short_description"
        case datumDescription = "description"
        case productImages
        case productInCart = "ProductInCart"
        case productInCartQty = "ProductInCartQty"
        case productInCartTotal = "ProductInCartTotal"
        case isProductFavoirte = "IsProductFavoirte"
        case currency
    }
}

struct ProductImage: Codable {
    let id: Int?
    let image: String?
    let productid: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case productid = "product_id"
    }
}

struct Review: Codable {
    let comment: String?
    let review: Int?
    let customer: Customer?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case comment, review, customer
        case createdAt = "created_at"
    }
}


struct Customer: Codable {
    let fullName, email, phone: String?
    let image: String?
    let firebaseToken, status, gender, promocode: String?
    let isGiftUsed: String?
    let giftid: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email, phone, image, firebaseToken, status, gender, promocode
        case isGiftUsed = "is_gift_used"
        case giftid = "gift_id"
        case createdAt = "created_at"
    }
}

struct Meta: Codable {
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
