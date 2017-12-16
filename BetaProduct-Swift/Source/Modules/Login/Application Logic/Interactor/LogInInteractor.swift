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
        guard let username = user.email?.trimmingCharacters(in: .whitespacesAndNewlines), isUsernameValid(username: username) else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Username incorrect!")
            return
        }
        
        guard let password = user.password?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: password) else {
            output?.userLoginValidationComplete(wasSuccessful: false, withMessage: "Password incorrect!")
            return
        }
        
        //UIDevice.current.identifierForVendor?.uuidString
        let deviceID = UUID.init(uuidString: "BF73F5D0-FD46-4478-B575-DBA6CD8A5367")
        webService?.POST(BetaProduct.kBPWSSessions(withEmail: username,
                                                   andWithPassword: password,
                                                   andWithDeviceID: (deviceID?.uuidString)!), parameters: nil, block: { response in
            switch response {
            case .success(let value):
                let token = Token.init(dictionary: value?.first as! [String: Any])
                self.session?.setToken(token)
                
                self.webService?.GET(BetaProduct.kBPWSUsers(withID: String(token.userId)), parameters: nil, block: { response in
                    switch response {
                    case .success(let value):
                        
                        self.managerLogin?.retrieveUser(withEmail: username, withCompletionBlock: { response in
                            switch response {
                            case .success(_):
                                self.session?.setUserSessionByUser(response.value!)
                                self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log in success!")
                            case .failure(_):
                                let user = User.init(dictionary: value!.first as! [String: Any])
                                self.managerCreate?.createAccount(withUser: user, withCompletionBlock: { response in
                                    self.session?.setUserSessionByUser(user)
                                    self.output?.userLoginValidationComplete(wasSuccessful: true, withMessage: "Log in success!")
                                })
                            }
                        })
                        
                    case .failure(let error):
                        self.output?.userLoginValidationComplete(wasSuccessful: false, withMessage: (error?.localizedDescription)!)
                    }
                })
                
            case .failure(let error):
                self.output?.userLoginValidationComplete(wasSuccessful: false, withMessage: (error?.localizedDescription)!)
            }
        })
    }
}
