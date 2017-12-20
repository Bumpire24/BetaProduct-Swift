//
//  ProductListInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// Protocol implementation for Product List Interactor (Input)
protocol ProductInteractorInput {
    /// Retrieves Products from a given data source
    func getProducts()
    func deleteProductByIndex(_ index: Int)
    func getProductDetailByIndex(_ index: Int)
    func getProductDetailById(_ id: Int16)
    func addProductToCartByProductId(_ id: Int16)
    func removeProductFromCartByProductId(_ id: Int16)
}

/// Protocol implementation for Product List Interactor (Output). Delegation
protocol ProductListInteractorOutput {
    /**
     Delegated method for product retrieval
     - Parameters:
        - products: passes products retrieved from data source
     */
    func gotProducts(_ products: [ProductListItem])
    func productListDeleteComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}

protocol ProductDetailInteractorOutput {
    func cartUpdateComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
    func gotProduct(_ product: ProductDetailItem?)
}
