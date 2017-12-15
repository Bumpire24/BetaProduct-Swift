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
    var id: Int16 = -1
    var firstName: String = ""
    var middleName: String = ""
    var lastName: String = ""
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
    /// variable for mobile/phone
    var mobile: String = ""
    /// variable for shipping address
    var addressShipping : String = ""
    /// variable for profile image url
    var profileImageURL : String = ""
}

/// extension for model User
extension User {
    var fullname: String { get {
        return firstName + " " + middleName + " " + lastName
        }}
    /**
     initializes Usser with the given inputs
     - Parameters:
        - email: email input
        - pass: password input
        - name: Full Name input
        - mobile: mobile/phone input
     */
    init(withUserID userID: Int16, withEmailAddress email: String, withLastName lname: String, withFirstName fName: String, withMiddleName mName: String, withAddressShipping addShip: String) {
        self.id = userID
        self.email = email
        self.lastName = lname
        self.firstName = fName
        self.middleName = mName
        self.addressShipping = addShip
    }
    
    /**
     Initializes User with the given inputs
     - Parameters:
        - dataDict: dictionary input. Uses WebserviceConverer class to retrieve values with given keys
     */
    init(dictionary dataDict: [String: Any]) {
        let wsConverter = WebServiceConverter.init(dataDict)
        self.email = wsConverter.stringWithKey("email")
        self.addressShipping = wsConverter.stringWithKey("addressShipping")
    }
}
