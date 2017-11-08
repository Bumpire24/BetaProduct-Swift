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
    var mainWireFrame : HomeWireframe?
    
    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }
    
    func installRootViewController(InWindow window : UIWindow) {
        // TEST
        mainWireFrame?.presentHomeViewInterfaceFromWindow(Window: window)
    }
    
    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        
        // Home Module Classes
        let homeWireframe = HomeWireframe()
        homeWireframe.rootWireFrame = root
        mainWireFrame = homeWireframe
    }
    
    func configureLibraries() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
}
