//
//  ShopCartWireframe.swift
//  BetaProduct-Swift
//
//  Created by Enrico Boller on 20/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let shopCartViewIdentifier = "ShopCartView"

class ShopCartWireframe: BaseWireframe, HomeTabBarInterface {
    var shopCartView : ShopCartView?
    
    func configuredViewController(_ viewController: HomeView) -> UIViewController {
        let shopCartViewControl = shopCartViewController()
        shopCartViewControl.tabBarItem = UITabBarItem.init(title: "Shop Cart", image: UIImage.init(imageLiteralResourceName: "shopcart"), tag: 1)
        return shopCartViewControl
    }
    
    func presentShopCartViewFromViewController(_ viewController: UIViewController) {
        let newViewController = shopCartViewController()
        shopCartView = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func shopCartViewController() -> ShopCartView {
        let shopCartViewController = mainStoryBoard().instantiateViewController(withIdentifier: shopCartViewIdentifier) as! ShopCartView
        return shopCartViewController
    }
}
