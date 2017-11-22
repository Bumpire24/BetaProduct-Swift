//
//  LogInInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

class LogInInteractor: NSObject, LogInInteractorInput {
    var session : Session?
    var webService : StoreWebClientProtocol?
    var manager : LogInManager?
    var output : LogInInteractorOutput?
    
    // validateLogIn
    // retrieve user using given input
    // check username nil, username has char
    // check password nil, password has char
    // check record exists
    func validateUserLogin(userDisplayItem user: UserDisplayItem) {
        // Check if inputs are complete
        guard let username = user.username, username.count > 0 else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Username incorrect!")
            return
        }
        
        guard let password = user.password, password.count > 0 else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Password incorrectx!")
            return
        }
        
        manager?.retrieveUser(withEmail: user.username!, andWithPassword: user.password!, withCompletionBlock: { response in
            switch response {
            case .success(_):
                self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log In success!")
            case .failure(let error):
                self.output?.userLoginValidationComplete(wasSuccessful: false, withMessage: (error?.localizedFailureReason)!)
            }
        })
    }
}
