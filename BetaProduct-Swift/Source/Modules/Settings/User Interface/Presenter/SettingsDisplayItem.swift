//
//  SettingsDisplayItem.swift
//  BetaProduct-Swift
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// Settings view model for module `Settings`
struct SettingsDisplayItem : BaseDisplayItem {
    /// variable for email
    var email : String?
    /// variable for password
    var password : String?
    /// variable for name
    var name : String?
    /// variable for mobile
    var mobile : String?
    /// variable for shipping address
    var addressShipping : String?
    /// variable for profile image url
    var profileImageURL : String?
    
    init() {
        email = ""
        password = ""
        name = ""
        mobile = ""
        addressShipping = ""
        profileImageURL = ""
    }
}
