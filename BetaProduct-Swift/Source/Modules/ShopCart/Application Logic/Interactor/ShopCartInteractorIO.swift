//
//  ShopCartInteractorIO.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol ShopCartInteractorInput {
    func getCart()
    func deleteProductByIndex(_ index: Int)
    func increaseQuantityOfProductByIndex(_ index: Int)
    func decreaseQuantityOfProductByIndex(_ index: Int)
    func deleteAllProductsInCart()
    func addProductToCartByProductId(_ id: Int16)
    func removeProductFromCartByProductId(_ id: Int16)
}

protocol ShopCartInteractorOuput {
    func gotCart(_ cart: ShopCartListDisplayItem?)
    func cartUpdateComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}

protocol ShopCartProductInteractorOutput {
    func cartUpdateComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}
