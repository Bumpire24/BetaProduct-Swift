//
//  ManagedUser.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/21/17.
//  Copyright © 2017 User. All rights reserved.
//
import Foundation
import CoreData

/// Core Data class Model for User
class ManagedUser: BaseEntity {
    /// variable for email
    @NSManaged var email: String
    /// variable for mobile/phone
    @NSManaged var mobile: String
    @NSManaged var firstName: String
    @NSManaged var middleName: String
    @NSManaged var lastName: String
    @NSManaged var id: Int16
    /// variable for mobile/phone
    @NSManaged var profileImageURL: String
    /// variable for Full Name
    @NSManaged var addressShipping: String
    @NSManaged var products: NSSet
    @NSManaged var shopcart: NSSet
}

extension ManagedUser {
    func addProduct(product: NSManagedObject) {
        let currentProducts = mutableSetValue(forKey: "products")
        currentProducts.add(product)
    }
    
    func removeProduct(product: NSManagedObject) {
        let currentProducts = mutableSetValue(forKey: "products")
        currentProducts.remove(product)
    }
    
    func addCart(cart: NSManagedObject) {
        let currentCart = mutableSetValue(forKey: "shopcart")
        currentCart.add(cart)
    }
    
    func removeCart(cart: NSManagedObject) {
        let currentCart = mutableSetValue(forKey: "shopcart")
        currentCart.remove(cart)
    }
}
