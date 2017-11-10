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
import CocoaLumberjack

class AppDependencies: NSObject {
    var mainWireFrame : HomeWireframe?
//    var mainWireFrame : LoginOptionsWireframe?
    
    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }
    
    func installRootViewController(InWindow window : UIWindow) {
        mainWireFrame?.presentHomeViewInterfaceFromWindow(Window: window)
    }
    
    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        
        // Home Module Classes
        let homeWireframe = HomeWireframe()
        homeWireframe.rootWireFrame = root
        mainWireFrame = homeWireframe
        
        //Login Options Module Classes
//        let loginOptionsPresenter = LoginOptionsPresenter()
//        let loginOptionsWireframe = LoginOptionsWireframe()
//        let loginWireframe = LoginWireframe()
//        loginOptionsWireframe.rootWireFrame = root
//        loginOptionsPresenter.loginOptionsWireframe = loginOptionsWireframe
//        loginOptionsWireframe.loginOptionsPresenter = loginOptionsPresenter
//        loginOptionsWireframe.loginWireframe = loginWireframe
//        mainWireFrame = loginOptionsWireframe
        
        // Product List Module Classes
//        let productListInteractor = ProductListInteractor()
//        let productListPresenter = ProductListPresenter()
    }
    
    func configureLibraries() {
        DDLog.add(DDTTYLogger.sharedInstance)
        DDLog.add(DDASLLogger.sharedInstance)
        
        let fileLogger: DDFileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        
        DDLog.add(fileLogger)
        
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")
        
//        #ifdef DEV
//        DDLogInfo(@"Development Environment");
//        #elif QA
//        DDLogInfo(@"QA Environment");
//        #elif PROD
//        DDLogInfo(@"QA Environment");
//        #endif
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0
    }
}
