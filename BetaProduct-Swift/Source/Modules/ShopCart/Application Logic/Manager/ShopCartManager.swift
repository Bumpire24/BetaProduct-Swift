//
//  ShopCartManager.swift
//  BetaProduct-Swift
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ShopCartManager: NSObject {
    var store: StoreProtocol?
    
    func createShopCart(withCart cart: ShopCart, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %d", Status.Deleted.rawValue, cart.userId)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response {
            case .success(let value):
                let managedUser = value?.first as! ManagedUser
                let newCart = self.store?.newShopCart()
                newCart?.quantity = 1
//                newCart?.user = managedUser =
                
                
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    func removeShopCart(withCart cart: ShopCart, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %d", Status.Deleted.rawValue, cart.userId)
    }
}
