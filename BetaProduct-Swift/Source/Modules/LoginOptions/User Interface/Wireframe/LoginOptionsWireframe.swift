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
    var rootWireFrame : RootWireframe?
    
    func presentLoginOptionsViewInterfaceFromWindow(Window window : UIWindow) {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: loginOptionsViewIdentifier) as! LoginOptionsView
        loginOptionsView = viewcontroller
        rootWireFrame?.showRootViewController(rootViewController: viewcontroller, inWindow: window)
    }

}
