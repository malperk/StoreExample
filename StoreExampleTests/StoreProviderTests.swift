//
//  StoreExampleTests.swift
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

final class StoreProviderSpec: QuickSpec {
    override func spec() {
        let provider = MoyaProvider<Store>()
        it("returns data for products request") {
            let target: Store = .products
            waitUntil(timeout: 5.0) { done in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        expect(response.statusCode).to(equal(200))
                        expect(response.data).toNot(beNil())
                    case .failure:
                        fail("Expect success request")
                    }
                    done()
                }
            }
        }
        
        it("returns add product to cart") {
            let target: Store = .addToCart(id: 2)
            waitUntil(timeout: 5.0) { done in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        expect(response.statusCode).to(equal(201))
                        expect(response.data).toNot(beNil())
                    case .failure:
                        fail("Expect success request")
                    }
                    done()
                }
            }
        }
        
        it("returns remove product from cart") {
            let target: Store = .removeFromCart(id: 2)
            waitUntil(timeout: 5.0) { done in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        expect(response.statusCode).to(equal(204))
                    case .failure:
                        fail("Expect success request")
                    }
                    done()
                }
            }
        }
    }
}
