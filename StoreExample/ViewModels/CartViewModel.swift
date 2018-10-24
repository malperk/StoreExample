//
//  CartViewModel.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import Moya

class CartViewModel {
    func fillItems(completion: @escaping CompletionClosure) {
        completion(.success)
    }
    func item(at: IndexPath) -> Product? {
        guard at.section == 0, at.row > -1, at.row < memoryCart.count else {
            return nil
        }
        let cart = memoryCart[at.row]
        return productCache.first(where: { $0.productID == cart.productID })
    }
    func countOfItems(inSection: Int) -> Int {
        guard inSection == 0 else {
            return 0
        }
        return memoryCart.count
    }
    func deleteItem(at: IndexPath, completion: @escaping CompletionClosure) {
        let item = self.item(at: at)!
        let provider = MoyaProvider<Store>(plugins: [MoyaHudPlugin()])
        let target: Store = .removeFromCart(id: item.productID)
        provider.request(target) { result in
            switch result {
            case .success(_):
                memoryCart.remove(at: at.row)
                completion(Status.success)
            case .failure(let error):
                completion(Status.error(error))
            }
        }
    }

    func totalPrice() -> String {
        var price = 0.0
        for chartItem in memoryCart {
            let item = productCache.first(where: { $0.productID == chartItem.productID })
            price += item?.price ?? 0
        }
        return String(format: "%.2f", price)
    }

}
