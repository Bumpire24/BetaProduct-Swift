//
//  LogInInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol LogInInteractorInput {
    /**
     Validates User Login with a given input. Will respond via Login Ouput delegate.
     - Parameters:
        - user: given input. Display Model
     */
    func validateUserLogin(userDisplayItem user: UserDisplayItem)
}

protocol LogInInteractorOutput {
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}
