//
//  ProductViewModel.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import Moya
import CoreData

class ProductViewModel: HasProduct, CartAddable, FavoritesAddable {
    // CartAddable protocol
    private func parse(data: Data) throws {
        var chartItem = try JSONDecoder().decode(CartItem.self, from: data)
        // Web service always return same product id which is 123 next line fix that
        chartItem.productID = product.productID
        memoryCart.append(chartItem)
    }

    func saveToCart(completion: @escaping CompletionClosure) {
        // check item
        if memoryCart.contains(where: { $0.productID == product.productID }) {
            completion(Status.error(CartAddableError.ItemAlreadyInCart(name: product.name)))
            return
        }
        // add item
        let provider = MoyaProvider<Store>(plugins: [MoyaHudPlugin()])
        let target: Store = .addToCart(id: product.productID)
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
                completion(.error(error))
            }
        }
    }

    func saveToFavorites(completion: @escaping CompletionClosure) {
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id == %d", product.productID)
            let result = try select(type: Favorite.self, request: fetchRequest)
            if result.count > 0 {
                completion(Status.error(FavoritesAddableError.ItemAlreadyInFavorites(name: product.name)))
                return
            }
            let item = try create(type: Favorite.self)
            item.name = product.name
            item.id = Int32(product.productID)
            try toSaveContext()
            completion(.success)
        } catch let error {
            completion(.error(error))
        }
    }
    // HasProduct Protocol
    var product: Product
    init(product: Product) {
        self.product = product
    }
}
