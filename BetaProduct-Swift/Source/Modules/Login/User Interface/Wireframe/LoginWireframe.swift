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
    
    func presentLoginViewFromViewController(_ viewController: UIViewController) {
        let newViewController = loginViewController()
        rootWireFrame?.showRootViewController(rootViewController: newViewController, inWindow: UIApplication.shared.keyWindow!)
        //viewController.present(newViewController, animated: true, completion: nil)
    }
    
    func loginViewController() -> LoginView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        return viewcontroller
    }

}
