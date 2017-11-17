//
//  LogInManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LogInManager: NSObject {
    let validUsers = [["username" : "user", "password" : "pass"],
                      ["username" : "sample", "password" : "sample"]]
    
    func retrieveUser(withUserName username : String, andWithPassword password : String, withCompletionBlock block : CompletionBlock<User?>) {
        var userFound : User? = nil
        _ = validUsers.contains(where: { dict in
            if dict["username"] == username && dict["password"] == password {
                userFound = User.init(dict["username"]!, pass: dict["password"]!)
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
