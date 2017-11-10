//
//  ProductListInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// Interactor Class for Module `Product List`
class ProductListInteractor: NSObject, ProductListInteractorInput {
    var output : ProductListInteractorOutput?
    var manager : ProductManager?
    
    // MARK: ProductListInteractorInput
    
    /// Protocol implementation. see `ProductListInteractorIO.swift`
    func getProducts() {
//        manager?.getProducts({ (success, error, result) in
//            
//        })
        
//        manager?.sample({ (result) in
//            switch result {
//                case .failure(let error)
//                case .success(let value)
//            }
//        })
    }
}
