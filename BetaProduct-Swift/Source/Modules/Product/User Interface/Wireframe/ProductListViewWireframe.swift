//
//  ProductListViewWireframe.swift
//  BetaProduct-Swift DEV
//
//  Created by Enrico Boller on 19/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let productsListViewIdentifier = "ProductsListView"

class ProductListViewWireframe: BaseWireframe, HomeTabBarInterface {
    var productDetailWireFrame : ProductDetailWireframe?
    var productsListPresenter : ProductListPresenter?
    var productsListInteractor : ProductInteractor?
    var productsListView : ProductsListView?
    
    func configuredViewController() -> UIViewController {
        let productsListViewControl = productListViewController()
        productsListViewControl.tabBarItem = UITabBarItem.init(title: "Products", image: UIImage.init(imageLiteralResourceName: "products"), tag: 1)
        return productsListViewControl
    }
    
    func presentProductsListViewFromViewController(_ viewController: UIViewController) {
        let newViewController = productListViewController()
        productsListView = newViewController
        productsListView?.eventHandler = productsListPresenter
        productsListPresenter?.productsListView = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func productListViewController() -> ProductsListView {
        let productsListViewController = mainStoryBoard().instantiateViewController(withIdentifier: productsListViewIdentifier) as! ProductsListView
        return productsListViewController
    }
}
