//
//  RootWireframe.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {

    func showRootViewController (rootViewController viewcontroller : UIViewController, inWindow window : UIWindow) {
        let navigationController = navigationControllerfromWindow(window)
        navigationController.viewControllers = [viewcontroller]
    }
    
    func navigationControllerfromWindow (_ window : UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
}
