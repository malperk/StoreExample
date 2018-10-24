//
//  StoreApi.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import Moya

public enum Store {
    case products
    case product(id: Int)
    case addToCart(id: Int)
    case removeFromCart(id: Int)
}

extension Store: TargetType {
    public var baseURL: URL {
        return URL(string: "https://private-anon-c93a9cf23b-ddshop.apiary-mock.com")!

    }

    public var path: String {
        switch self {
        case .products:
            return "/products"
        case .product(let id):
            return "/product/\(id)"
        case .addToCart(_):
            return "/cart"
        case .removeFromCart(let id):
            return "/cart/\(id)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .products, .product(_):
            return .get
        case .addToCart(_):
            return .post
        case .removeFromCart(_):
            return .delete
        }

    }

    public var sampleData: Data {
        return "".data(using: .utf8)!
    }

    public var task: Task {
        return .requestPlain
    }

    public var headers: [String: String]? {
        return nil
    }

}
