//
//  User.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct User : ModelProtocol {
    var status: Int16 = Int16(Status.Active.rawValue)
    var syncStatus: Int16 = Int16(SyncStatus.Created.rawValue)
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    var col1: String = ""
    var col2: String = ""
    var col3: String = ""
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var mobile: String = ""
    
    init(emailAddress email: String, password pass: String) {
        self.email = email
        self.password = pass
    }
    
    init(emailAddress email: String, password pass: String, fullName name: String, mobileNumber mobile: String) {
        self.init(emailAddress: email, password: pass)
        self.fullname = name
        self.mobile = mobile
    }
}
