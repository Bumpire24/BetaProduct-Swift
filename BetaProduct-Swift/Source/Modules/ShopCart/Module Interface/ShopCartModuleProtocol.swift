//
//  ShopCartModuleProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol ShopCartModuleProtocol {
    func getAllProducts()
    func deleteProduct(byIndex index: Int)
    func addProductQuantity(byIndex index: Int)
    func subtractProductQuantity(byIndex index: Int)
    func clearAllProducts()
}

protocol ShopCartAddRemoveModuleProtocol {
    func addProduct(byProductId id: Int)
    func removeProduct(byProductId id: Int)
}

protocol ShopCartAddRemoveModuleDelegateProtocol {
    func isAddRemoveSuccessful(isAddRemoveSuccessful: Bool)
}
