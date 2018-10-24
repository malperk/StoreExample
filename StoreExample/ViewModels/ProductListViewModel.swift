//
//  ProductListViewModel.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import Moya

class ProductListViewModel: HasProductListWithSection {
    private var productSections: [String]?
    private var productList: [String: Products]?

    private func parse(data: Data) throws {
        productCache = try JSONDecoder().decode(Products.self, from: data)
        productList = Dictionary(grouping: productCache, by: { $0.category })
        productSections = Array(productList!.keys).sorted(by: <)
    }

    func fillProducts(completion: @escaping CompletionClosure) {
        let provider = MoyaProvider<Store>(plugins: [MoyaHudPlugin()])
        let target: Store = .products
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    try self.parse(data: response.data)
                    completion(Status.success)
                } catch let error {
                    completion(Status.error(error))
                }
            case .failure(let error):
                completion(Status.error(error))
            }
        }
    }

    func countOfSections() -> Int {
        return productSections?.count ?? 0
    }

    func countOfProducts(inSection: Int) -> Int {
        guard productSections != nil, inSection > -1, inSection < productSections!.count else {
            return 0
        }
        let key = productSections![inSection]

        return productList?[key]?.count ?? 0
    }

    func product(at: IndexPath) -> Product? {
        guard productSections != nil, at.section > -1, at.section < productSections!.count else {
            return nil
        }
        let key = productSections![at.section]
        guard at.row > -1, at.row < productList?[key]?.count ?? 0 else {
            return nil
        }
        let product = productList?[key]?[at.row]
        return product
    }

    func categoryName(inSection: Int) -> String? {
        guard productSections != nil, inSection > -1, inSection < productSections!.count else {
            return nil
        }
        return productSections?[inSection]
    }

}
