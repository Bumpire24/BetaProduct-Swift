//
//  SettingsDisplayItem.swift
//  BetaProduct-Swift
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

protocol SettingsDisplayItemProtocol: BaseDisplayItem {
    
}

struct SettingsProfileDisplayItem : SettingsDisplayItemProtocol, Equatable {
    /// variable for name
    var name : String?
    /// variable for mobile
    var mobile : String?
    /// variable for shipping address
    var addressShipping : String?
    /// variable for profile image url
    var profileImage : (url: String?, image: UIImage?)
    
    static func ==(lhs: SettingsProfileDisplayItem, rhs: SettingsProfileDisplayItem) -> Bool {
        return lhs.name == rhs.name && lhs.mobile == rhs.mobile && lhs.addressShipping == rhs.addressShipping && lhs.profileImage.url == rhs.profileImage.url && lhs.profileImage.image == rhs.profileImage.image
    }
}

struct SettingsEmailDisplayItem : SettingsDisplayItemProtocol {
    /// variable for old email address
    var emailAddOld: String?
    /// variable for new email address
    var emailAddNew: String?
    /// variable for confirm new email address
    var emailAddNewConfirm: String?
}

struct SettingsPasswordDisplayItem : SettingsDisplayItemProtocol {
    /// variable for old password
    var passwordOld: String?
    /// variable for new password
    var passwordNew: String?
    /// variable for confirm new password
    var passwordNewConfirm: String?
}


