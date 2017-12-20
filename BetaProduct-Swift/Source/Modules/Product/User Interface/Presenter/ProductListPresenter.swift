//
//  ProductListPresenter.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ProductListPresenter: NSObject, ProductListModuleProtocol, ProductListInteractorOutput {
    var interactor : ProductInteractorInput?
    var productsListView : ProductsListViewProtocol?
    
    func getAllProducts() {
        interactor?.getProducts()
    }
    
    func removeProductItem(withIndex index: Int) {
        interactor?.deleteProductByIndex(index)
    }
    
    func gotProducts(_ products: [ProductListItem]) {
        productsListView?.displayProducts(products)
    }
    
    func productListDeleteComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        productsListView?.deleteProductItemFromCollection()
    }
}
