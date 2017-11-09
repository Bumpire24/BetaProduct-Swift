//
//  LoginOptionsWireframe.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let loginOptionsViewIdentifier = "LoginOptionsView"

class LoginOptionsWireframe: BaseWireframe {
    var loginOptionsView : LoginOptionsView?
    var loginOptionsPresenter : LoginOptionsPresenter?
    var rootWireFrame : RootWireframe?
    var loginWireframe : LoginWireframe?
    
    func presentLoginOptionsViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginOptionsViewIdentifier) as! LoginOptionsView
        viewcontroller.eventHandler = loginOptionsPresenter
        loginOptionsView = viewcontroller
        loginOptionsPresenter?.view = viewcontroller
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentLoginViewFromViewController(_ viewController: UIViewController) {
        loginWireframe?.presentLoginViewFromViewController(viewController)
    }
    
    func presentLoginView() {
        loginWireframe?.presentLoginViewFromViewController(loginOptionsView!)
    }
}
