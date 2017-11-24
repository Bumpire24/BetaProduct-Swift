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
    var loginPresenter : LogInPresenter?
    var homeWireFrame : HomeWireframe?
    var createAccountWireframe : CreateAccountWireframe?
    var window: UIWindow?
    
//    func presentLoginViewInterfaceFromWindow(Window window : UIWindow) {
//        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
//        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
//    }
    
    func presentLoginViewInterfaceFromWindow(Window window : UIWindow) {
        self.window = window
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        viewcontroller.eventHandler = loginPresenter
        loginView = viewcontroller
        loginPresenter?.view = viewcontroller
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentLoginViewFromViewController(_ viewController: UIViewController) {
        let newViewController = loginViewController()
        loginView = newViewController
        loginView?.eventHandler = loginPresenter
        loginPresenter?.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func presentHomeView() {
        homeWireFrame?.presentHomeViewFromViewController(loginView!)
    }
    
    func presentCreateAccount() {
        createAccountWireframe?.presentCreateAccountViewFromViewController(loginView!)
    }
    
    func loginViewController() -> LoginView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginViewIdentifier) as! LoginView
        return viewcontroller
    }
}
