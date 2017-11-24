//
//  CreateAccountWireframe.swift
//  BetaProduct-Swift
//
//  Created by User on 11/16/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let createAccountViewIdentifier = "CreateAccountView"

class CreateAccountWireframe: BaseWireframe {
    var createAccountView : CreateAccountView?
    var rootWireFrame : RootWireframe?
    var presenter : CreateAccountPresenter?
    var loginWireFrame : LoginWireframe?
    
    func presentCreateAccountViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: createAccountViewIdentifier) as! CreateAccountView
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }
    
    func presentCreateAccountViewFromViewController(_ viewController: UIViewController) {
        let newViewController = createAccountViewController()
        createAccountView = newViewController
        createAccountView?.eventHandler = presenter
        presenter?.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func presentLoginView() {
        createAccountView?.navigationController?.popViewController(animated: true)
    }
    
    private func createAccountViewController() -> CreateAccountView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: createAccountViewIdentifier) as! CreateAccountView
        return viewcontroller
    }
}
