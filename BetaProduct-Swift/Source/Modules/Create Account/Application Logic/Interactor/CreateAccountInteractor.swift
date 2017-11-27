//
//  CreateAccountInteractor.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// interactor class for module `Create Account`
class CreateAccountInteractor : NSObject, CreateAccountInteractorInput {
    /// variable for create account data manager
    var createAccountManager : CreateAccountManager?
    /// variable for output delegate
    var output : CreateAccountInteractorOutput?
    /// variable for webservice
    var webService : StoreWebClientProtocol?
    
    // MARK: Privates
    /// validate Email. calls isInputValid for generic input validation
    private func isEmailValid(email: String) -> Bool {
        return isInputValid(input:email) && email.isValidEmail()
    }
    
    /// validate Password. calls isInputValid for generic input validation
    private func isPasswordValid(password: String) -> Bool {
        // TODO: Password Encryption
        return isInputValid(input: password)
    }
    
    /// validate mobile. calls isInputValid for generic input validation
    private func isMobileValid(mobile: String) -> Bool {
        return isInputValid(input: mobile) && mobile.isValidPhone()
    }
    
    /// validate mobile. calls isInputValid for generic input validation
    private func isFullNameValid(name: String) -> Bool {
        return isInputValid(input: name)
    }
    
    // validate inputs. Generic handle for input validations
    private func isInputValid(input: String) -> Bool {
        if input.count == 0 {
            return false
        }
        return true
    }
    
    // MARK: CreateAccountInteractorInput
    // use case
    // validate Account Credentials
    // retrieve account with the given input
    // check email nil, email whitespace, valid email
    // check password nil, password whitespace
    // call WS
    // check account if valid for creation
    
    /// implements protocol. see `CreateAccountInteractorIO.swift`
    func validateAccountCredentials(_ loginDisplay: UserCredentialsItem) {
        // validate inputs
        guard let username = loginDisplay.email?.trimmingCharacters(in: .whitespacesAndNewlines), isEmailValid(email: username) else {
            output?.createAccountSuccessful(false, message: "Username incorrect!")
            return
        }
        
        guard let password = loginDisplay.password?.trimmingCharacters(in: .whitespacesAndNewlines), isPasswordValid(password: password) else {
            output?.createAccountSuccessful(false, message: "Password incorrect!")
            return
        }
        
        guard let mobileNumber = loginDisplay.mobileNumber?.trimmingCharacters(in: .whitespacesAndNewlines), isMobileValid(mobile: mobileNumber) else {
            output?.createAccountSuccessful(false, message: "Mobile Number incorrect!")
            return
        }
        
        guard let fullName = loginDisplay.fullName?.trimmingCharacters(in: .whitespacesAndNewlines), isFullNameValid(name: fullName) else {
            output?.createAccountSuccessful(false, message: "Full Name incorrect!")
            return
        }
        
        // call WS and validate account
        webService?.POST(BetaProduct.kBPWSPostUser, parameters: loginDisplay.allProperties(), block: { response in
            switch response {
            case .success(_):
                self.output?.createAccountSuccessful(true, message: "Account creation Successful!")
            case .failure(let error):
                self.output?.createAccountSuccessful(false, message: (error?.localizedFailureReason)!)
            }
        })
    }
}
