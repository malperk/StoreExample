//
//  ProductViewModelTests.swift
//  StoreExampleTests
//
//  Created by Alper KARATAS on 10/24/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//
import XCTest
import Quick
import Nimble
@testable import StoreExample

final class ProductViewModelTests: QuickSpec {
    override func spec() {
        let product = Product(productID: 1, name: "Test Product", category: "Test Category", price: 10, oldPrice: nil, stock: 0)
        let viewModel = ProductViewModel(product: product)

        it("check save to chart") {
            waitUntil(timeout: 5.0) { done in
                viewModel.saveToCart(completion: { status in
                    switch status {
                    case .success:
                        viewModel.saveToCart(completion: { status in
                            switch status {
                            case .success:
                                fail("Product can't be add twice.")
                            case .error(let error):
                                expect(error).notTo(beNil())
                            }
                            done()
                        })
                    case .error(let error):
                        expect(error).to(beNil())
                    }
                })
            }
        }

        it("check save to favorites") {
            do {
                try deleteAll(type: Favorite.self)
            } catch {
                fail("Expect success")
            }
            waitUntil(timeout: 5.0) { done in
                viewModel.saveToFavorites(completion: { status in
                    switch status {
                    case .success:
                        viewModel.saveToFavorites(completion: { status in
                            switch status {
                            case .success:
                                fail("Product can't be add twice.")
                            case .error(let error):
                                expect(error).notTo(beNil())
                                //clean
                                do {
                                    try deleteAll(type: Favorite.self)
                                } catch {
                                    fail("Expect success")
                                }
                            }
                            done()
                        })
                    case .error(_):
                        fail("Expect success")
                    }
                })
            }
        }
        
    }
}
