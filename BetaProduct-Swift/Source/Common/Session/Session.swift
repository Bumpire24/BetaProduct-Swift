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
    private var hasSynced: Bool = false
    
    /// struct declaration for UserSession. Will be the data object class for session User
    struct UserSession {
        /// variable for email
        var email : String?
        /// variable for Full Name
        var fullName : String?
        /// variable for Mobile/Phone Number
        var mobile : String?
        /// variable for Shipping Address
        var addShipping: String?
        /// variable for Profile Image
        var imageURLProfile: String?
        var token: String?
        var tokenExpiry: Int16?
        var firstName: String?
        var middleName: String?
        var lastName: String?
        var id: Int16?
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
        self.user?.id = user.id
        self.user?.email = user.email
        self.user?.firstName = user.firstName
        self.user?.middleName = user.middleName
        self.user?.lastName = user.lastName
        self.user?.fullName = user.fullname
        self.user?.mobile = user.mobile
        self.user?.addShipping = user.addressShipping
        self.user?.imageURLProfile = user.profileImageURL
    }
    
    /// gets User Model from UserSession
    func getUserSessionAsUser() -> User {
        return User.init(withUserID: user?.id ?? -1,
                         withEmailAddress: user?.email ?? "",
                         withLastName: user?.lastName ?? "",
                         withFirstName: user?.firstName ?? "",
                         withMiddleName: user?.lastName ?? "",
                         withAddressShipping: user?.addShipping ?? "")
    }
    
    func getToken() -> String? {
        return user?.token
    }
    
    func setToken(_ token: String?) {
        self.user?.token = token
    }
    
    func hasAlreadySynced() -> Bool {
        return hasSynced
    }
    
    func markSyncCompleted() {
        hasSynced = true
    }
}
