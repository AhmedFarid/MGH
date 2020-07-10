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
    let status, featured, trending, isNew: String?
    let bestSeller, off50, onSale, hotDeal: String?
    let hotDealPrice, expireDateHotDeal, productCode, porductSkuCode: String?
    let productSerialNumber, linkYoutube: String?
    let stock, stockLimitAlert, countSolid, numberViews: Int?
    let numberClicks, totalRate, totalNumberReview, salePrice: Int?
    let discount, total: Int?
    let totalWithCurrency: String?
    let image: String?
    let category, subcategory, brand, name: String?
    let shortDescription, datumDescription: String?
    let productImages: [ProductImage]?
    let productInCart, productInCartQty, productInCartTotal, isProductFavoirte: Int?
    let currency: String?

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
        case salePrice = "sale_price"
        case discount, total
        case totalWithCurrency = "total_with_currency"
        case image, category, subcategory, brand, name
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
    let productID: Int?

    enum CodingKeys: String, CodingKey {
        case id, image
        case productID = "product_id"
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
