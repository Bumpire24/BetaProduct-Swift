//
//  ProductsModuleProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 12/14/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol ProductListModuleProtocol {
    func getAllProducts()
    func removeProductItem(withIndex index: Int)
}

protocol ProductDetailModuleProtocol {
    func getProductItem(atIndex index: Int)
    func getProductItem(byId id: Int16)
    func addToCartById(_ id: Int16)
    func removeFromCartById(_ id: Int16)
}
