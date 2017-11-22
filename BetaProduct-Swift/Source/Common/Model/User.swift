//
//  User.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// model struct for Module `Login`
struct User : ModelProtocol {
    /// variable for status. see Status Enum
    var status: Int16 = Int16(Status.Active.rawValue)
    /// variable for sync status. see SyncStatus Enum
    var syncStatus: Int16 = Int16(SyncStatus.Created.rawValue)
    /// variable for created date
    var createdAt: Date = Date()
    /// variable for modified date
    var modifiedAt: Date = Date()
    /// variable for extra column
    var col1: String = ""
    /// variable for extra column
    var col2: String = ""
    /// variable for extra column
    var col3: String = ""
    /// variable for email
    var email: String = ""
    /// variable for email
    var password: String = ""
    /// variable for password
    var fullname: String = ""
    /// variable for mobile/phone
    var mobile: String = ""
}

/// extension for model User
extension User {
    /**
     initializes Usser with the given inputs
     - Parameters:
        - email: email input
        - pass: password input
     */
    init(emailAddress email: String, password pass: String) {
        self.email = email
        self.password = pass
    }
    
    /**
     initializes Usser with the given inputs
     - Parameters:
        - email: email input
        - pass: password input
        - name: Full Name input
        - mobile: mobile/phone input
     */
    init(emailAddress email: String, password pass: String, fullName name: String, mobileNumber mobile: String) {
        self.init(emailAddress: email, password: pass)
        self.fullname = name
        self.mobile = mobile
    }
    
    /**
     Initializes User with the given inputs
     - Parameters:
        - dataDict: dictionary input. Uses WebserviceConverer class to retrieve values with given keys
     */
    init(dictionary dataDict: [String: Any]) {
        let wsConverter = WebServiceConverter.init(dataDict)
        self.email = wsConverter.stringWithKey("email")
        self.password = wsConverter.stringWithKey("password")
        self.fullname = wsConverter.stringWithKey("fullname")
        self.mobile = wsConverter.stringWithKey("mobile")
    }
}
