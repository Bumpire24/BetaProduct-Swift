//
//  ManagedUser.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/21/17.
//  Copyright © 2017 User. All rights reserved.
//

class ManagedUser: BaseEntity {
    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var mobile: String
    @NSManaged var fullname: String
}
