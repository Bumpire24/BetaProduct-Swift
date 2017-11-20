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
//    var mainWireFrame : HomeWireframe?
    var mainWireFrame : LoginOptionsWireframe?
    
    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }
    
    func installRootViewController(InWindow window : UIWindow) {
//        mainWireFrame?.presentHomeViewInterfaceFromWindow(Window: window)
        mainWireFrame?.presentLoginOptionsViewInterfaceFromWindow(Window: window)
    }
    
    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        
        // Home Module Classes
//        let homeWireframe = HomeWireframe()
//        homeWireframe.rootWireFrame = root
//        mainWireFrame = homeWireframe
        
        //Login Options Module Classes
        let loginOptionsPresenter = LoginOptionsPresenter()
        let loginOptionsWireframe = LoginOptionsWireframe()
        let loginWireframe = LoginWireframe()
        let createAccountWireframe = CreateAccountWireframe()
        loginOptionsWireframe.rootWireFrame = root
        loginOptionsPresenter.loginOptionsWireframe = loginOptionsWireframe
        loginOptionsPresenter.createAccountWireframe = createAccountWireframe
        loginOptionsWireframe.loginOptionsPresenter = loginOptionsPresenter
        loginOptionsWireframe.loginWireframe = loginWireframe
        loginOptionsWireframe.createAccountWireframe = createAccountWireframe
        mainWireFrame = loginOptionsWireframe
        
        //Login Module Classes
        let loginManager = LogInManager()
        let loginInteractor = LogInInteractor()
        let loginPresenter = LogInPresenter()
        
        loginInteractor.manager = loginManager
        loginInteractor.output = loginPresenter
        
        loginPresenter.interactor = loginInteractor
        loginWireframe.presenter = loginPresenter
        
        //Create Account Classes
        let createAccountManager = CreateAccountManager()
        let createAccountInteractor = CreateAccountInteractor()
        let createAccountPresenter = CreateAccountPresenter()
        
        createAccountInteractor.createAccountManager = createAccountManager
        createAccountInteractor.loginManager = loginManager
        createAccountInteractor.output = createAccountPresenter
        
        createAccountPresenter.interactor = createAccountInteractor
        createAccountWireframe.presenter = createAccountPresenter
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
        
        #if DEV
            DDLogInfo("Development Environment")
        #elseif QA
            DDLogInfo("QA Environment")
        #elseif PROD
            DDLogInfo("Production Environment")
        #endif
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0
    }
}
