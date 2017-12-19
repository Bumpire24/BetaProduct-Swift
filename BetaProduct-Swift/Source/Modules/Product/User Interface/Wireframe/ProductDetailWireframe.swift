//
//  ProductDetailWireframe.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let productDetailViewIdentifier = "ProductDetailView"

class ProductDetailWireframe: BaseWireframe {
    var productDetailView : ProductDetailView?
    var productDetailPresenter : ProductDetailPresenter?
    
    func presentProductDetailViewFromViewController(_ viewController: UIViewController, productIndex: Int) {
        let newViewController = productDetailViewController()
        productDetailView = newViewController
        productDetailView?.eventHandler = productDetailPresenter
        productDetailPresenter?.productDetailView = newViewController
        viewController.navigationController?.present(newViewController, animated: true, completion: nil)
        newViewController.fetchProductDetail(ofItemIndexAt: productIndex)
    }
    
    private func productDetailViewController() -> ProductDetailView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: productDetailViewIdentifier) as! ProductDetailView
        return viewcontroller
    }
}
