//
//  CartFavorites.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation

// CartAddable Errors
enum CartAddableError: Error {
    case ItemAlreadyInCart(name: String)

    public var description: String {
        return "CartAddableError: \(caseDescription)"
    }

    var caseDescription: String {
        switch self {
        case .ItemAlreadyInCart(let name):
            return "Item \(name) already in cart"
        }
    }
}
// FavoritesAddable Errors
enum FavoritesAddableError: Error {
    case ItemAlreadyInFavorites(name: String)
    
    public var description: String {
        return "FavoritesAddableError: \(caseDescription)"
    }
    
    var caseDescription: String {
        switch self {
        case .ItemAlreadyInFavorites(let name):
            return "Item \(name) already in favorites"
        }
    }
}

protocol CartAddable {
    func saveToCart(completion: @escaping CompletionClosure)
}

protocol FavoritesAddable {
    func saveToFavorites(completion: @escaping CompletionClosure)
}
