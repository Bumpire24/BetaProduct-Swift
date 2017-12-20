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
    private var mainWireFrame : LoginWireframe?
    private var presenterHome: SettingsHomeModuleProtocol?

    override init() {
        super.init()
        configureLibraries()
        configureDependencies()
    }

    func showLoginViewAndClearSession(InWindow window: UIWindow) {
        presenterHome?.logout()
        mainWireFrame?.presentLoginViewInterfaceFromWindow(Window: window)
    }

    func installRootViewController(InWindow window : UIWindow) {
        mainWireFrame?.presentLoginViewInterfaceFromWindow(Window: window)
    }

    func configureDependencies() {
        // Root Level Classes
        let root = RootWireframe()
        let store = StoreCoreData()
        let webservice = StoreWebClient()
        let webserviceFake = StoreWebClientFake()
        let session = Session.sharedSession

        webservice.session = session

        let loginWireframe = LoginWireframe()
        let createAccountWireframe = CreateAccountWireframe()
        let homeWireframe = HomeWireframe()
        let settingsWireframe = SettingsWireframe()
        let settingsProfileWireframe = SettingsProfileWireframe()
        let settingsChangeEmailWireframe = SettingsChangeEmailWireframe()
        let settingsChangePasswordWireframe = SettingsChangePasswordWireframe()
        let productDetailWireframe = ProductDetailWireframe()

        //Login Module Classes
        let loginPresenter = LogInPresenter()
        loginWireframe.rootWireFrame = root
        loginPresenter.loginWireframe = loginWireframe
        loginWireframe.loginPresenter = loginPresenter
        loginWireframe.createAccountWireframe = createAccountWireframe
        mainWireFrame = loginWireframe

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

        //Products Classes
        let productsManager = ProductManager()
        let productsInteractor = ProductInteractor()
        let productsPresenter = ProductListPresenter()
        let productDetailPresenter = ProductDetailPresenter()

        productsManager.store = store
        productsInteractor.manager = productsManager
        productsInteractor.webservice = webserviceFake
        productsInteractor.session = session
        productsInteractor.outputList = productsPresenter
        productsInteractor.outputDetail = productDetailPresenter
        homeWireframe.productsPresenter = productsPresenter
        productsPresenter.interactor = productsInteractor
        productDetailPresenter.interactor = productsInteractor
        productDetailWireframe.productDetailPresenter = productDetailPresenter

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

        settingsInteractor.outputHome = settingsHomePresenter
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

        //Change Password Settings Classes
        let changePasswordSettingsPresenter = SettingsPresenterPassword()
        settingsInteractor.outputPassword = changePasswordSettingsPresenter
        changePasswordSettingsPresenter.interactor = settingsInteractor
        changePasswordSettingsPresenter.changePasswordSettingsWireframe = settingsChangePasswordWireframe
        settingsChangePasswordWireframe.presenter = changePasswordSettingsPresenter
        presenterHome = settingsHomePresenter
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
