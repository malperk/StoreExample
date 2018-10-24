//
//  ProductListViewModelTests.swift
//  StoreExampleTests
//
//  Created by Alper KARATAS on 10/24/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import StoreExample

final class ProductListViewModelTests: QuickSpec {
    override func spec() {
        it("check fills Product") {
            let viewModel = ProductListViewModel()

            waitUntil(timeout: 5.0) { done in
                viewModel.fillProducts(completion: { status in
                    switch status {
                    case .success:
                        let count = viewModel.countOfSections()
                        expect(count).to(be(6))
                        let section0Count = viewModel.countOfProducts(inSection: 0)
                        expect(section0Count).to(be(2))
                        let emptySectionCount = viewModel.countOfProducts(inSection: 1000)
                        expect(emptySectionCount).to(be(0))
                        let product = viewModel.product(at: IndexPath(row: 0, section: 0))
                        expect(product?.productID).to(be(8))
                        let emptyProduct1 = viewModel.product(at: IndexPath(row: -1, section: 0))
                        expect(emptyProduct1).to(beNil())
                        let emptyProduct2 = viewModel.product(at: IndexPath(row: 0, section: 1000))
                        expect(emptyProduct2).to(beNil())
                        let categoryName = viewModel.categoryName(inSection: 0)
                        expect(categoryName).to(equal("Men\'s Casualwear"))
                        let emptyCategoryName = viewModel.categoryName(inSection: 1000)
                        expect(emptyCategoryName).to(beNil())
                    case .error(_):
                        fail("Expect success")
                    }
                    done()
                })
            }
        }

        it("check empty Product") {
            let viewModel2 = ProductListViewModel()
            let count = viewModel2.countOfSections()
            expect(count).to(be(0))
            let section0Count = viewModel2.countOfProducts(inSection: 0)
            expect(section0Count).to(be(0))
            let emptySectionCount = viewModel2.countOfProducts(inSection: 1000)
            expect(emptySectionCount).to(be(0))
            let product = viewModel2.product(at: IndexPath(row: 0, section: 0))
            expect(product?.productID).to(beNil())
            let emptyProduct1 = viewModel2.product(at: IndexPath(row: -1, section: 0))
            expect(emptyProduct1).to(beNil())
            let emptyProduct2 = viewModel2.product(at: IndexPath(row: 0, section: 1000))
            expect(emptyProduct2).to(beNil())
            let categoryName = viewModel2.categoryName(inSection: 0)
            expect(categoryName).to(beNil())
            let emptyCategoryName = viewModel2.categoryName(inSection: 1000)
            expect(emptyCategoryName).to(beNil())
        }

    }
}
