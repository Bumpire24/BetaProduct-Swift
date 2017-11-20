//
//  LogInManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LogInManager: NSObject {
    let validUsers = [["email" : "user", "password" : "pass"],
                      ["email" : "asd@gmail.com", "password" : "asd"]]
    
    func retrieveUser(withEmail email : String, andWithPassword password : String, withCompletionBlock block : CompletionBlock<User?>) {
        var userFound : User? = nil
        _ = validUsers.contains(where: { dict in
            if dict["email"] == email && dict["password"] == password {userFound = User.init(emailAddress: dict["email"]!, password: dict["password"]!)
                return true
            } else {
                return false
            }
        })
        
        if userFound != nil {
            block(Response.success(userFound))
        } else {
            block(Response.failure(BPError.init(domain: BetaProduct.kBetaProductErrorDomain,
                                                code: .Business,
                                                description: "No Record Found!",
                                                reason: "No Record Found!",
                                                suggestion: "Try Again")))
        }
    }
}
