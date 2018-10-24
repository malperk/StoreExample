//
//  ListSection.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation

enum Status {
    case success
    case error(Error)
}
typealias CompletionClosure = (Status) -> Void


///Product Protocols
protocol HasProductList {
    func fillProducts(completion: @escaping CompletionClosure)
    func product(at: IndexPath) -> Product?
}
protocol HasProductListWithSection:HasProductList {
    func countOfSections() -> Int
    func countOfProducts(inSection: Int) -> Int
    func categoryName(inSection: Int) -> String?
}

protocol HasProduct {
    var product: Product { get }
}

