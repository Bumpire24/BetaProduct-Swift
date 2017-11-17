//
//  CreateAccountPresenter.swift
//  BetaProduct-Swift
//
//  Created by User on 11/16/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class CreateAccountPresenter: NSObject, CreateAccountModuleProtocol, CreateAccountInteractorOutput {
    var view : CreateAccountViewProtocol?
    var interactor : CreateAccountInteractorInput?
    
    func validateUserCredentials(_ user: UserCredentialsItem) {
        interactor?.validateAccountCredentials(user)
    }

    func createAccountSuccessful(_ wasSuccessful: Bool, message: String) {
        view?.displayMessage(message)
    }
}
