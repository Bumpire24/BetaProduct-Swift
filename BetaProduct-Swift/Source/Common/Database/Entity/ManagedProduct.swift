//
//  Product.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import CoreData

class ManagedProduct: BaseEntity {
    @NSManaged var name :               String
    @NSManaged var weblink :            String
    @NSManaged var productDescription : String
    @NSManaged var price :              Double
    @NSManaged var priceDescription :   String
    @NSManaged var imageUrl :           String
    @NSManaged var imageThumbUrl :      String
    @NSManaged var imageCompanyUrl :    String
    @NSManaged var productId :          Int16
    @NSManaged var users: NSSet
    @NSManaged var shopcart: NSSet
}

extension ManagedProduct {
    func addUser(user: NSManagedObject) {
        let currentUsers = mutableSetValue(forKey: "users")
        currentUsers.add(user)
    }
    
    func removeUser(user: NSManagedObject) {
        let currentUsers = mutableSetValue(forKey: "users")
        currentUsers.remove(user)
    }
    
    func addShopCart(cart: NSManagedObject) {
        let currentCart = mutableSetValue(forKey: "shopcart")
        currentCart.add(cart)
    }
    
    func removeShopCart(cart: NSManagedObject) {
        let currentCart = mutableSetValue(forKey: "shopcart")
        currentCart.remove(cart)
    }
}
