//
//  HomeWireframe.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

let homeViewIdentifier = "HomeView"
let qrViewIdentifier = "QRView"
let productsListViewIdentifier = "ProductsListView"

class HomeWireframe: BaseWireframe {
    var homeView : HomeView?
    var rootWireFrame : RootWireframe?
    var settingsWireFrame : SettingsWireframe?
    var presenter : HomeModulePresenter?
    var productsPresenter : ProductListPresenter?
    
    func presentHomeViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: homeViewIdentifier) as! HomeView
        homeView = viewcontroller
        viewcontroller.eventHandler = presenter
        assembleViewControllersForHomeView()
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentHomeViewFromViewController(_ viewController: UIViewController) {
        let newViewController = homeViewController()
        homeView = newViewController
        newViewController.eventHandler = presenter
        assembleViewControllersForHomeView()
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func homeViewController() -> HomeView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: homeViewIdentifier) as! HomeView
        return viewcontroller
    }
    
    func assembleViewControllersForHomeView() {
        let qrView = createQRView()
        let productListView = createProductsListViewView()
        let shopCartView = UIViewController.init()
        
        qrView.view.backgroundColor = UIColor.red;
        productListView.view.backgroundColor = UIColor.yellow;
        shopCartView.view.backgroundColor = UIColor.blue;
        
        productListView.eventHandler = productsPresenter

        let tabViewControllers = [qrView, productListView, shopCartView]
        homeView?.setViewControllers(tabViewControllers, animated: true)
        
        qrView.tabBarItem = UITabBarItem.init(title: "QR Code Scanner", image: UIImage.init(imageLiteralResourceName: "qr"), tag: 1)
        productListView.tabBarItem = UITabBarItem.init(title: "Products", image: UIImage.init(imageLiteralResourceName: "products"), tag: 1)
        shopCartView.tabBarItem = UITabBarItem.init(title: "Shop Cart", image: UIImage.init(imageLiteralResourceName: "shopcart"), tag: 1)
    }
    
    func createQRView() -> QRView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: qrViewIdentifier) as! QRView
        return viewcontroller
    }
    
    func createProductsListViewView() -> ProductsListView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: productsListViewIdentifier ) as! ProductsListView
        return viewcontroller
    }
    
    func presentSettingsView() {
        settingsWireFrame?.presentSettingsViewFromViewController(homeView!)
    }
}
