//
//  Cart.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation

//Shopping cart cache
var memoryCart: [CartItem] = []

struct CartItem: Codable {
    var cartID, productID: Int

    enum CodingKeys: String, CodingKey {
        case cartID = "cartId"
        case productID = "productId"
    }
}
