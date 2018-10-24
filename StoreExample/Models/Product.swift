//
//  Product.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation

// Product Shopping cart
var productCache: Products = []

typealias Products = [Product]

struct Product: Codable {
    let productID: Int
    let name, category: String
    let price: Double
    let oldPrice: Double?
    let stock: Int

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case name, category, price, oldPrice, stock
    }
}
