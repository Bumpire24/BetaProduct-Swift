//
//  UserSession.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/21/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class Session: NSObject {
    static let sharedSession = Session()
    
    struct UserSession {
        var email : String?
        var password : String?
        var fullName : String?
        var mobile : String?
    }
    
    var user : UserSession?
    
    func dismissCurrentUser() {
        user = nil
    }
    
    func setUserSessionByUser(_ user: User) {
        self.user?.email = user.email
        self.user?.password = user.password
        self.user?.fullName = user.fullname
        self.user?.mobile = user.mobile
    }
    
    func getUserSessionAsUser() -> User {
        return User.init(emailAddress: user?.email ?? "", password: user?.password ?? "", fullName: user?.fullName ?? "", mobileNumber: user?.mobile ?? "")
    }
}
