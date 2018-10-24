//
//  ProductModelTests.swift
//  StoreExampleTests
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Moya
@testable import StoreExample

final class ProductModelTests: QuickSpec {
    override func spec() {
        let provider = MoyaProvider<Store>()
        let target: Store = .products
        var productsData:Data?
        waitUntil(timeout: 5.0) { done in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    productsData = response.data
                case .failure:
                    fail("Expect success request")
                }
                done()
            }
        }
        it("check products data") {
            expect(productsData).notTo(beNil())
        }
        it("parse products data to product model") {
            let products = try? JSONDecoder().decode(Products.self, from: productsData!)
            expect(products).toNot(beNil())
            expect(products!.count).to(equal(13))
        }
        
        
    }
}
