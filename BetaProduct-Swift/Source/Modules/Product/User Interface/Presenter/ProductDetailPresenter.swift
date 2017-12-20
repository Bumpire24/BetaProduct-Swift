//
//  ProductDetailPresenter.swift
//  BetaProduct-Swift DEV
//
//  Created by Enrico Boller on 18/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ProductDetailPresenter: NSObject, ProductDetailModuleProtocol, ProductDetailInteractorOutput {
    var interactor: ProductInteractorInput?
    var productDetailView : ProductDetailViewProtocol?
    private var persistedProductId: Int16?
    
    func getProductItem(atIndex index: Int) {
        interactor?.getProductDetailByIndex(index)
    }
    
    func getProductItem(byId id: Int16) {
        persistedProductId = id
        interactor?.getProductDetailById(id)
    }
    
    func gotProduct(_ product: ProductDetailItem?) {
        productDetailView?.displayProductInformation(productItem: product!)
    }
    
    func addToCartById(_ id: Int16) {
        interactor?.addProductToCartByProductId(id)
    }
    
    func removeFromCartById(_ id: Int16) {
        interactor?.removeProductFromCartByProductId(id)
    }
    
    func cartUpdateComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        if isSuccess {
            interactor?.getProductDetailById(persistedProductId!)
        } else {
            productDetailView?.displayMessage(message)
        }
    }
}
