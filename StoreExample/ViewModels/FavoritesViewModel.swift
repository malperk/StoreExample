//
//  FavoritesViewModel.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import CoreData

class FavoritesViewModel {
    private var favorites: [Favorite]?
    func fillFavorites(completion: @escaping CompletionClosure) {
        do {
            try favorites = selectAll(type: Favorite.self)
            completion(.success)
        } catch let error {
            completion(.error(error))
        }
    }
    func product(at: IndexPath) -> Product? {
        guard at.section == 0, at.row > -1, favorites != nil, at.row < favorites!.count else {
            return nil
        }
        let favorite = favorites![at.row]

        return productCache.first(where: { $0.productID == favorite.id })
    }

    func favorite(at: IndexPath) -> Favorite? {
        guard at.section == 0, at.row > -1, favorites != nil, at.row < favorites!.count else {
            return nil
        }
        return favorites![at.row]
    }
    func countOfFavorites(inSection: Int) -> Int {
        guard inSection == 0 else {
            return 0
        }
        return favorites?.count ?? 0
    }

    func deleteItem(at: IndexPath, completion: @escaping CompletionClosure) {
        do {
            let item = self.favorites![at.row]
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id == %d", item.id)
            let result = try select(type: Favorite.self, request: fetchRequest)
            for obj in result {
                delete(object: obj)
            }
            try toSaveContext()
            try favorites = selectAll(type: Favorite.self)
            completion(.success)
        } catch let error {
            completion(.error(error))
        }
    }

}
