//
//  LogInPresenter.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LogInPresenter: NSObject, LogInModuleProtocol, LogInInteractorOutput {
    var view : LoginViewProtocol?
    var interactor : LogInInteractorInput?
    var loginWireframe : LoginWireframe?
    
    func validateUser(_ user: UserDisplayItem) {
        interactor?.validateUserLogin(userDisplayItem: user)
    }
    
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        view?.displayMessage(message)
    }
    
    func proceedToHomeView() {
        loginWireframe?.presentHomeView()
    }
}
