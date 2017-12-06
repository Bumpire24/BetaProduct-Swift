//
//  ManagedUser.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/21/17.
//  Copyright © 2017 User. All rights reserved.
//


/// Core Data class Model for User
class ManagedUser: BaseEntity {
    /// variable for email
    @NSManaged var email: String
    /// variable for password
    @NSManaged var password: String
    /// variable for mobile/phone
    @NSManaged var mobile: String
    /// variable for Full Name
    @NSManaged var fullname: String
    /// variable for mobile/phone
    @NSManaged var profileImageURL: String
    /// variable for Full Name
    @NSManaged var addressShipping: String
    @NSManaged var products: Set<ManagedProduct>
}
