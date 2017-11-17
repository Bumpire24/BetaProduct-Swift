//
//  CreateAccountInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/16/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol CreateAccountInteractorInput {
    func validateAccountCredentials(_ loginDisplay: UserCredentialsItem)
}

protocol CreateAccountInteractorOutput {
    func createAccountSuccessful(_ wasSuccessful : Bool)
}
