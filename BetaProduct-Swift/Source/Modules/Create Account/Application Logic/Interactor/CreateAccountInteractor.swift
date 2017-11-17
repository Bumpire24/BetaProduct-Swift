//
//  CreateAccountInteractor.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class CreateAccountInteractor : NSObject, CreateAccountInteractorInput {
    var loginManager : LogInManager?
    var createAccountManager : CreateAccountManager?
    var output : CreateAccountInteractorOutput?
    
    func validateAccountCredentials(_ loginDisplay: UserCredentialsItem) {
        // Check if nil, whitespace email
        // Check email format
        // Check if nil, whitespace pass
        // Check if nil, whitespace name
        // Check if nil, whitespace mobile
        // Check if record already exists
        guard let username = loginDisplay.email, username.count > 0, username.isValidEmail() else {
            output?.createAccountSuccessful(false, message: "Username incorrect!")
            return
        }
        
        guard let password = loginDisplay.password, password.count > 0 else {
            output?.createAccountSuccessful(false, message: "Password incorrect!")
            return
        }
        
        guard let mobileNumber = loginDisplay.mobileNumber, mobileNumber.count > 0, mobileNumber.isValidPhone() else {
            output?.createAccountSuccessful(false, message: "Mobile Number incorrect!")
            return
        }
        
        guard let fullName = loginDisplay.fullName, fullName.count > 0 else {
            output?.createAccountSuccessful(false, message: "Full Name incorrect!")
            return
        }
        
        let user = User.init(emailAddress: loginDisplay.email!, password: loginDisplay.password!, fullName: loginDisplay.fullName!, mobileNumber: loginDisplay.mobileNumber!)
        
        loginManager?.retrieveUser(withEmail: user.email, andWithPassword: user.password, withCompletionBlock: { response in
            if response.isSuccess {
                output?.createAccountSuccessful(false, message: "Account already exists!")
            } else {
                createAccountManager?.createAccount(withUser: user, withCompletionBlock: { response in
                    switch response {
                    case .success(_):
                        output?.createAccountSuccessful(true, message: "Account creation Successful!")
                    case .failure(let error):
                        output?.createAccountSuccessful(false, message: (error?.localizedFailureReason)!)
                    }
                })
            }
        })
    }
}
