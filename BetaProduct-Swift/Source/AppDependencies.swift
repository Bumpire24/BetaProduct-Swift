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
//    var mainWireFrame : LoginOptionsWireframe?
    var mainWireFrame : LoginWireframe?
    
    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }
    
    func installRootViewController(InWindow window : UIWindow) {
//        mainWireFrame?.presentHomeViewInterfaceFromWindow(Window: window)
//        mainWireFrame?.presentLoginOptionsViewInterfaceFromWindow(Window: window)
        mainWireFrame?.presentLoginViewInterfaceFromWindow(Window: window)
    }
    
    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        let store = StoreCoreData()
        let webservice = StoreWebClient()
        let session = Session.sharedSession
        
        // Home Module Classes
//        let homeWireframe = HomeWireframe()
//        homeWireframe.rootWireFrame = root
//        mainWireFrame = homeWireframe
        
        //Login Options Module Classes
//        let loginOptionsWireframe = LoginOptionsWireframe()
        
        let loginWireframe = LoginWireframe()
        let createAccountWireframe = CreateAccountWireframe()
        let homeWireframe = HomeWireframe()
        let settingsWireframe = SettingsWireframe()
        let settingsProfileWireframe = SettingsProfileWireframe()
        let settingsChangeEmailWireframe = SettingsChangeEmailWireframe()
        let settingsChangePasswordWireframe = SettingsChangePasswordWireframe()
        
        //Login Module Classes
        let loginPresenter = LogInPresenter()
        loginWireframe.rootWireFrame = root
        loginPresenter.loginWireframe = loginWireframe
        loginWireframe.loginPresenter = loginPresenter
        loginWireframe.createAccountWireframe = createAccountWireframe
        mainWireFrame = loginWireframe
        
//        let loginOptionsPresenter = LoginOptionsPresenter()
//        loginOptionsWireframe.rootWireFrame = root
//        loginOptionsPresenter.loginOptionsWireframe = loginOptionsWireframe
//        loginOptionsPresenter.createAccountWireframe = createAccountWireframe
//        loginOptionsWireframe.loginOptionsPresenter = loginOptionsPresenter
//        loginOptionsWireframe.loginWireframe = loginWireframe
//        loginOptionsWireframe.createAccountWireframe = createAccountWireframe
//        mainWireFrame = loginOptionsWireframe
        
        //
        let loginManager = LogInManager()
        loginManager.store = store
        
        let loginInteractor = LogInInteractor()
        loginInteractor.managerLogin = loginManager
        loginInteractor.webService = webservice
        loginInteractor.output = loginPresenter
        loginInteractor.session = session
        
        loginPresenter.interactor = loginInteractor
        loginWireframe.homeWireFrame = homeWireframe
        
        //Create Account Classes
        let createAccountManager = CreateAccountManager()
        let createAccountInteractor = CreateAccountInteractor()
        let createAccountPresenter = CreateAccountPresenter()
        
        createAccountManager.store = store
        
        createAccountInteractor.createAccountManager = createAccountManager
        createAccountInteractor.webService = webservice
        createAccountInteractor.output = createAccountPresenter
        
        loginInteractor.managerCreate = createAccountManager
        
        createAccountPresenter.interactor = createAccountInteractor
        createAccountPresenter.wireframeCreateAccount = createAccountWireframe
        
        createAccountWireframe.presenter = createAccountPresenter
        
        //Home Classes
        let homePresenter = HomeModulePresenter()
        homeWireframe.settingsWireFrame = settingsWireframe
        homePresenter.homeWireframe = homeWireframe
        homeWireframe.presenter = homePresenter
        
        //Settings Classes
        let settingsHomePresenter = SettingsPresenterHome()
        settingsWireframe.profileSettingsWireframe = settingsProfileWireframe
        settingsWireframe.changeEmailSettingsWireframe = settingsChangeEmailWireframe
        settingsWireframe.changePasswordSettingsWireframe = settingsChangePasswordWireframe
        settingsHomePresenter.wireframeSettings = settingsWireframe
        settingsWireframe.settingsPresenter = settingsHomePresenter
        
        //Profile Settings Classes
        let settingsManager = SettingsManager()
        let settingsInteractor = SettingsInteractor()
        let profileSettingsPresenter = SettingsPresenterProfile()
        
        settingsManager.store = store
        settingsInteractor.manager = settingsManager
        settingsInteractor.webservice = webservice
        settingsInteractor.session = session
        settingsInteractor.outputProfile = profileSettingsPresenter
        
        settingsHomePresenter.interactor = settingsInteractor
        
        profileSettingsPresenter.interactor = settingsInteractor
        profileSettingsPresenter.profileSettingsWireframe = settingsProfileWireframe
        settingsProfileWireframe.presenter = profileSettingsPresenter
        
        //Change Email Settings Classes
        let changeEmailSettingsPresenter = SettingsPresenterEmail()
        settingsInteractor.outputEmail = changeEmailSettingsPresenter
        changeEmailSettingsPresenter.interactor = settingsInteractor
        changeEmailSettingsPresenter.changeEmailSettingsWireframe = settingsChangeEmailWireframe
        settingsChangeEmailWireframe.presenter = changeEmailSettingsPresenter
        
        let managerProduct = ProductManager()
        managerProduct.store = store
        managerProduct.retrieveProducts(withCompletionBlock: { response in })
        
//        managerProduct.createProduct(withProduct: Product.init(productName: "Name",
//                                                               productDescription: "Name",
//                                                               productId: 1,
//                                                               productPrice: "Name",
//                                                               productPriceDescription: "Name",
//                                                               productWeblink: "Name",
//                                                               productImageURL: "Name",
//                                                               productImageThumbURL: "Name",
//                                                               productImageCompanyURL: "Name"),
//                                     withCompletionBlock: { response in })
//
//        managerProduct.createProduct(withProduct: Product.init(productName: "Name",
//                                                               productDescription: "Name",
//                                                               productId: 1,
//                                                               productPrice: "Name",
//                                                               productPriceDescription: "Name",
//                                                               productWeblink: "Name",
//                                                               productImageURL: "Name",
//                                                               productImageThumbURL: "Name",
//                                                               productImageCompanyURL: "Name"),
//                                     withCompletionBlock: { response in })
//
//        managerProduct.createProduct(withProduct: Product.init(productName: "Name",
//                                                               productDescription: "Name",
//                                                               productId: 1,
//                                                               productPrice: "Name",
//                                                               productPriceDescription: "Name",
//                                                               productWeblink: "Name",
//                                                               productImageURL: "Name",
//                                                               productImageThumbURL: "Name",
//                                                               productImageCompanyURL: "Name"),
//                                     withCompletionBlock: { response in })
        
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
