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

class HomeWireframe: BaseWireframe {
    var homeView : HomeView?
    var rootWireFrame : RootWireframe?
    var settingsWireFrame : SettingsWireframe?
    var qrCodeWireframe : QRCodeWireframe?
    var productListWireframe: ProductListViewWireframe?
    var shopCartWireframe : ShopCartWireframe?
    var presenter : HomeModulePresenter?
    var productsPresenter : ProductListPresenter?
    var wireFrames: [HomeTabBarInterface]?
    
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
        
        var homeTabViewControllers = [UIViewController]()
        homeTabViewControllers.append(qrCodeWireframe!.configuredViewController(homeView!))
        homeTabViewControllers.append(productListWireframe!.configuredViewController(homeView!))
        homeTabViewControllers.append(shopCartWireframe!.configuredViewController(homeView!))
        
        homeView?.setViewControllers(homeTabViewControllers, animated: true)
        homeView?.navigationItem.title = "iDooh"
    }
    
    func presentSettingsView() {
        settingsWireFrame?.presentSettingsViewFromViewController(homeView!)
    }
}
