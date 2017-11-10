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
    var presenter : LogInPresenter?
    
    func presentLoginViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentLoginViewFromViewController(_ viewController: UIViewController, Window window : UIWindow) {
        let newViewController = loginViewController()
        loginView = newViewController
        loginView?.eventHandler = presenter
        presenter?.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func loginViewController() -> LoginView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        return viewcontroller
    }
}
