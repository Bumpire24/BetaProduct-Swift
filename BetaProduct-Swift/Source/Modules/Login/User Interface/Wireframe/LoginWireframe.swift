//
//  LoginWireframe.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let loginViewIdentifier = "LoginView"

class LoginWireframe: BaseWireframe {
    var loginView : LoginView?
    var rootWireFrame : RootWireframe?
    
    func presentLoginViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        loginView = viewcontroller
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentLoginViewFromViewController(_ viewController: UIViewController, Window window : UIWindow) {
        let newViewController = loginViewController()
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func loginViewController() -> LoginView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        return viewcontroller
    }
}
