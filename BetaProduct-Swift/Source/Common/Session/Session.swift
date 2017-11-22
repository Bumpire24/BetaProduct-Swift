//
//  UserSession.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/21/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// session class for the app
class Session: NSObject {
    /// variable for shared Session. Singleton Pattern
    static let sharedSession = Session()
    
    /// struct declaration for UserSession. Will be the data object class for session User
    struct UserSession {
        /// variable for email
        var email : String?
        /// variable for password
        var password : String?
        /// variable for Full Name
        var fullName : String?
        /// variable for Mobile/Phone Number
        var mobile : String?
    }
    
    /// variable for usersession
    var user : UserSession?
    
    /// clears user Session
    func dismissCurrentUser() {
        user = nil
    }
    
    /// sets UserSession by Model User
    func setUserSessionByUser(_ user: User) {
        self.user = UserSession()
        self.user?.email = user.email
        self.user?.password = user.password
        self.user?.fullName = user.fullname
        self.user?.mobile = user.mobile
    }
    
    /// gets User Model from UserSession
    func getUserSessionAsUser() -> User {
        return User.init(emailAddress: user?.email ?? "", password: user?.password ?? "", fullName: user?.fullName ?? "", mobileNumber: user?.mobile ?? "")
    }
}
