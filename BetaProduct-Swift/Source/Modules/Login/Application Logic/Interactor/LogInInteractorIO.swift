//
//  LogInInteractorIO.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol LogInInteractorInput {
    func validateLogIn(_ loginDisplay: UserDisplayItem)
}

protocol LogInInteractorOutput {
    func loginSuccessful(_ wasSuccessful : Bool)
}
