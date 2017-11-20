//
//  LogInInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol LogInInteractorInput {
    func validateUserLogin(userDisplayItem user: UserDisplayItem)
}

protocol LogInInteractorOutput {
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String)
}
