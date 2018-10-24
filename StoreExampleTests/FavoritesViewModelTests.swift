//
//  FavoritesViewModelTests.swift
//  StoreExampleTests
//
//  Created by Alper KARATAS on 10/24/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import StoreExample

final class FavoritesViewModelTests: QuickSpec {
    override func spec() {
        do {
            try deleteAll(type: Favorite.self)
        } catch {
            fail("Expect success")
        }
        
        let product = Product(productID: 1, name: "Test Product", category: "Test Category", price: 10, oldPrice: nil, stock: 0)
        productCache.append(product)
        let productViewModel = ProductViewModel(product: product)
        waitUntil(timeout: 5.0) { done in
            productViewModel.saveToFavorites(completion: { status in
                switch status {
                case .success:
                    done()
                case .error(_):
                    fail("Expect success")
                }
            })
        }

        let viewModel = FavoritesViewModel()

        it("check fills Favorites") {
            waitUntil(timeout: 5.0) { done in
                viewModel.fillFavorites(completion: { status in
                    switch status {
                    case .success:
                        let product = viewModel.product(at: IndexPath(row: 0, section: 0))
                        expect(product?.productID).to(be(1))
                        let emptyProduct1 = viewModel.product(at: IndexPath(row: -1, section: 0))
                        expect(emptyProduct1).to(beNil())
                        let emptyProduct2 = viewModel.product(at: IndexPath(row: 0, section: 1000))
                        expect(emptyProduct2).to(beNil())
                        let favorite = viewModel.favorite(at: IndexPath(row: 0, section: 0))
                        expect(favorite?.id).to(equal(1))
                        let emptyFavorite1 = viewModel.favorite(at: IndexPath(row: -1, section: 0))
                        expect(emptyFavorite1?.id).to(beNil())
                        let emptyFavorite2 = viewModel.favorite(at: IndexPath(row: 0, section: 1000))
                        expect(emptyFavorite2?.id).to(beNil())
                        //clean
                        do {
                            try deleteAll(type: Favorite.self)
                        } catch {
                            fail("Expect success")
                        }                    case .error(_):
                        fail("Expect success")
                    }
                    done()
                })
            }
        }
    }
}
