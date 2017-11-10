//
//  LogInManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LogInManager: NSObject {
    let validUser = (username : "user", password : "pass")
    
    func validateUser(_ user : User, block : CompletionBlock<Bool>) {
        if user.username == validUser.username, user.password == validUser.password {
            block(Response.success(true))
        } else {
            block(Response.failure(BPError.init()))
        }
    }
}
