//
//  AppDependencies.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit
import AlamofireNetworkActivityIndicator

class AppDependencies: NSObject {
    //var mainWireFrame : HomeWireframe?
    var mainWireFrame : LoginOptionsWireframe?
    
    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }
    
    func installRootViewController(InWindow window : UIWindow) {
        //mainWireFrame?.presentHomeViewInterfaceFromWindow(Window: window)
        mainWireFrame?.presentLoginOptionsViewInterfaceFromWindow(Window: window)
    }
    
    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        
//        // Home Module Classes
//        let homeWireframe = HomeWireframe()
//        homeWireframe.rootWireFrame = root
//        mainWireFrame = homeWireframe
        
        //Login Options Module Classes
        let loginOptionsPresenter = LoginOptionsPresenter()
        let loginOptionsWireframe = LoginOptionsWireframe()
        let loginWireframe = LoginWireframe()
        loginOptionsWireframe.rootWireFrame = root
        loginOptionsPresenter.loginOptionsWireframe = loginOptionsWireframe
        loginOptionsWireframe.loginOptionsPresenter = loginOptionsPresenter
        loginOptionsWireframe.loginWireframe = loginWireframe
        mainWireFrame = loginOptionsWireframe
    }
    
    func configureLibraries() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
}
