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
    var manager : LogInManager?
    var output : LogInInteractorOutput?
    
    //validateLogIn
    // check username nil, username has char
    // check password nil, password has char
    // check record exists
    // retrieve user using given input
    
    func validateLogIn(_ loginDisplay: UserDisplayItem) {
        // Check if inputs are complete
        guard let username = loginDisplay.username, username.count > 0 else {
            output?.loginSuccessful(false, message: "Username incorrect!")
            return
        }
        
        guard let password = loginDisplay.password, password.count > 0 else {
            output?.loginSuccessful(false, message: "Password incorrect!")
            return
        }
        
        manager?.retrieveUser(withUserName: loginDisplay.username!, andWithPassword: loginDisplay.password!, withCompletionBlock: { response in
            switch response {
            case .success(_):
                output?.loginSuccessful(true, message: "Log In success!")
            case .failure(let error):
                output?.loginSuccessful(false, message: (error?.localizedFailureReason)!)
            }
        })
    }
}
