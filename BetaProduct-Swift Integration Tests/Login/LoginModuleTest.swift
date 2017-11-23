//
//  LoginModuleTest.swift
//  BetaProduct-Swift Integration Tests
//
//  Created by User on 11/23/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV__Integration_Tests_

/// Integration Test class for module `Login`
class LoginModuleTest: XCTestCase, LogInInteractorOutput {
    /// variable for Store
    let store = StoreCoreData()
    /// variable for  Store Web Client
    let webservice = StoreWebClient()
    /// variable for Session
    let session = Session.sharedSession
    /// variable for Login Manager
    var managerLogin : LogInManager?
    /// variable for Create Account Manager
    var managerCreateAccount : CreateAccountManager?
    /// variable for wireframe
    var wireframe : LoginWireframe?
    /// variable for view
    var view : LoginView?
    /// variable for interactor
    var interactor : LogInInteractor?
    /// variable for presenter
    var presenter : LogInPresenter?
    /// variable for expectation
    var expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        managerCreateAccount = CreateAccountManager()
        managerLogin = LogInManager()
        interactor = LogInInteractor()
        presenter = LogInPresenter()
        wireframe = LoginWireframe()
        view = LoginView()
        
        managerCreateAccount?.store = store
        managerLogin?.store = store
        
        interactor?.webService = webservice
        interactor?.output = self
        interactor?.session = session
        interactor?.managerLogin = managerLogin
        interactor?.managerCreate = managerCreateAccount
        
        presenter?.interactor = interactor
        presenter?.loginWireframe = wireframe
        presenter?.view = view
        
        wireframe?.presenter = presenter
        view?.eventHandler = presenter
    }
    
    override func tearDown() {
        managerLogin = nil
        managerCreateAccount = nil
        interactor = nil
        presenter = nil
        wireframe = nil
        view = nil
        super.tearDown()
    }
    
    func testExample() {
        self.expectation = expectation(description: "testPerformanceExample")
        let item = UserDisplayItem(email: "sample@gmail.com", password: "sample")
        view?.eventHandler?.validateUser(item)
        self.waitForExpectations(timeout: 10) { _ in
        }
    }
    
    /// LogInInteractorOutput protocol implementation
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        if expectation != nil {
            expectation?.fulfill()
        }
    }
}
