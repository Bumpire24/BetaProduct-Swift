//
//  User.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct User : ModelProtocol {
    var username:           String
    var password:           String
    let status:             Int16
    let syncStatus:         Int16
    let createdAt:          Date
    let modifiedAt:         Date
    let col1:               String
    let col2:               String
    let col3:               String
    
    init() {
        username = ""
        password = ""
        status = Int16(Status.Active.rawValue)
        syncStatus = Int16(SyncStatus.Created.rawValue)
        createdAt = Date()
        modifiedAt = Date()
        col1 = ""
        col2 = ""
        col3 = ""
    }
    
    init(_ user : String, pass : String) {
        username = user
        password = pass
        status = Int16(Status.Active.rawValue)
        syncStatus = Int16(SyncStatus.Created.rawValue)
        createdAt = Date()
        modifiedAt = Date()
        col1 = ""
        col2 = ""
        col3 = ""
    }
}
