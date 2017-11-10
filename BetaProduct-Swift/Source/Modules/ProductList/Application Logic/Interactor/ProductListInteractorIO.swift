//
//  ProductListInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// Protocol implementation for Product List Interactor (Input)
protocol ProductListInteractorInput {
    /// Retrieves Products from a given data source
    func getProducts()
}

/// Protocol implementation for Product List Interactor (Output). Delegation
protocol ProductListInteractorOutput {
    /**
     Delegated method for product retrieval
     - Parameters:
        - products: passes products retrieved from data source
     */
    func gotProducts(_ products: [Product])
}
