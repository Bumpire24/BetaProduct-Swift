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
    
    func validateUser(_ user: UserDisplayItem) {
        interactor?.validateLogIn(user)
    }
    
    func loginSuccessful(_ wasSuccessful: Bool, message: String) {
        view?.displayMessage(message)
    }
}
