//
//  ProductDetailPresenter.swift
//  BetaProduct-Swift DEV
//
//  Created by Enrico Boller on 18/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ProductDetailPresenter: NSObject, ProductModuleProtocol, ProductDetailInteractorOutput {
    var interactor : ProductInteractorInput?
    var productDetailView : ProductDetailViewProtocol?
    
    func getProductItem(atIndex index: Int) {
        interactor?.getProductDetailByIndex(index)
    }
    
    func gotProduct(_ product: ProductDetailItem?) {
        productDetailView?.displayProductInformation(productItem: product!)
    }
}
