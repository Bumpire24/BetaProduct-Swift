//
//  LogInInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

/// interactor class for Module 'Login'
class LogInInteractor: NSObject, LogInInteractorInput {
    /// variable for Session.
    var session : Session?
    /// variable for webservice
    var webService : StoreWebClientProtocol?
    /// variable for data manager
    var managerLogin : LogInManager?
    /// variable for output delegate
    var output : LogInInteractorOutput?
    /// variable for create account manager
    var managerCreate : CreateAccountManager?
    
    // MARK: privates
    /// validate Username. calls isInputValid for generic input validation
    private func isUsernameValid(username: String) -> Bool {
        return isInputValid(input:username) && username.isValidEmail()
    }
    
     /// validate Password. calls isInputValid for generic input validation
    private func isPasswordValid(password: String) -> Bool {
        // TODO: Password Encryption
        return isInputValid(input: password)
    }
    
    // validate inputs. Generic handle for input validations
    private func isInputValid(input: String) -> Bool {
        if input.count == 0 {
            return false
        }
        return true
    }
    
    // MARK: LogInInteractorInput
    
    // use case
    // validateLogIn
    // retrieve user using given input
    // check username nil, username whitespace, username trim, valid email
    // check password nil, password whitespace, password trim
    // call WS
    // authenticate account
    // check if account exists in db
    // insert new record
    // Save User to Session
    
    /// implements protocol. see 'LogInInteractorIO.swift'
    func validateUserLogin(userDisplayItem user: UserDisplayItem) {
        // validate inputs
        guard let username = user.email, isUsernameValid(username: username.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Username incorrect!")
            return
        }
        
        guard let password = user.password, isPasswordValid(password: password.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Password incorrect!")
            return
        }
        // call WS and authenticate account
        webService?.POST(BetaProduct.kBPWSPostUser, parameters: user.allProperties(), block: { response in
            switch response {
            case .success(let value):
                // check if account already exists in db
                self.managerLogin?.retrieveUser(withEmail: username, andWithPassword: password, withCompletionBlock: { response in
                    if response.isSuccess {
                        // update account in db
                        // TODO: account updation
                        self.session?.setUserSessionByUser(response.value!)
                        self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log in success!")
                    } else {
                        // else add account in db
                        if let list = value, let targetUser = list.first, let converted = targetUser as? [String:Any] {
                            let newUser = User.init(dictionary: converted)
                            self.managerCreate?.createAccount(withUser: newUser, withCompletionBlock: { response in
                                self.session?.setUserSessionByUser(newUser)
                                self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log in success!")
                            })
                        } else {
                            // failed to convert User
                            print("Failed to Convert User")
                            self.session?.setUserSessionByUser(User.init(emailAddress: username, password: password))
                            self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log in success!")
                        }
                    }
                })
            case .failure(let error):
                self.output?.userLoginValidationComplete(wasSuccessful: false, withMessage: (error?.localizedFailureReason)!)
            }
        })
    }
}
