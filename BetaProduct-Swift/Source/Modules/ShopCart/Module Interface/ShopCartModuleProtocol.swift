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
    func showProductDetail(withId id: Int16)
}
