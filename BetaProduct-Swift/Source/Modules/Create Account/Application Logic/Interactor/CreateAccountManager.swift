//
//  CreateAccountManager.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class CreateAccountManager : NSObject {
    let validUsers = [["email" : "user", "password" : "pass"],
                      ["email" : "sample", "password" : "sample"]]
    
    func createAccount(withUser user : User, withCompletionBlock block : CompletionBlock<Bool>) {
        block(Response.success(true))
    }
}
