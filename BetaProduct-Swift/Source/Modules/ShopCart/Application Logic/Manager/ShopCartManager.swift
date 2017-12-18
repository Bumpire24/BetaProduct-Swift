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
                newCart?.user = managedUser
                
                let productPredicate = NSPredicate.init(format: "status != %d AND productId == %d", Status.Deleted.rawValue, cart.productId)
                self.store?.fetchEntries(withEntityName: "Product", withPredicate: productPredicate, withSortDescriptors: nil, withCompletionBlock: { response in
                    switch response {
                    case .success(let value):
                        let managedProduct = value?.first as! ManagedProduct
                        newCart?.product = managedProduct
                        self.store?.saveWithCompletionBlock(block: { response in
                            switch response {
                            case .success(_): block(.success(true))
                            case .failure(let error): block(.failure(error))
                            }
                        })
                    case .failure(let error): block(.failure(error))
                    }
                })
                
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    func deleteShopCart(withCart cart: ShopCart, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %d", Status.Deleted.rawValue, cart.userId)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response {
            case .success(let value):
                let managedUser = value?.first as! ManagedUser
                let managedShopCart = managedUser.shopcart.map({ $0 as! ManagedShopCart }).first(where: { $0.product.productId == cart.productId })
                if let nonNilShopCart = managedShopCart {
                    self.store?.deleteShopCart(cart: nonNilShopCart)
                    self.store?.saveWithCompletionBlock(block: { response in
                        switch response {
                        case .success(_):block(.success(true))
                        case .failure(let error): block(.failure(error))
                        }
                    })
                } else {
                    let error = BPError.init(domain: BetaProduct.kBPErrorDomain, code: .Database, description: "Unable to find the Product", reason: BetaProduct.kBPGenericError, suggestion: "Debug function \(#function)")
                    block(.failure(error))
                }
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    func deleteAll(withUser user: User, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %d", Status.Deleted.rawValue, user.id)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response {
            case .success(let value):
                let managedUser = value?.first as! ManagedUser
                for shopCart in managedUser.shopcart.map({ $0 as! ManagedShopCart }) {
                    self.store?.deleteShopCart(cart: shopCart)
                }
                self.store?.saveWithCompletionBlock(block: { response in
                    switch response {
                    case .success(_):block(.success(true))
                    case .failure(let error): block(.failure(error))
                    }
                })
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    func retrieveShopCart (withUser user: User, withCompletionBlock block: @escaping CompletionBlock<[ShopCart]>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %@", Status.Deleted.rawValue, user.id)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate,
                            withSortDescriptors: nil,
                            withCompletionBlock: { response in
                                switch response {
                                case .success(let value):
                                    let managedUser = value?.first as! ManagedUser
                                    block(.success(self.ShopCartFromManagedShopCart(cart: managedUser.shopcart.map({ $0 as! ManagedShopCart }))))
                                case .failure(let error): block(.failure(error))
                                }
        })
    }
    
    func updateShopCart(cart: ShopCart, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND id == %d", Status.Deleted.rawValue, cart.userId)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response {
            case .success(let value):
                let managedUser = value?.first as! ManagedUser
                let managedShopCart = managedUser.shopcart.map({ $0 as! ManagedShopCart }).first(where: { $0.product.productId == cart.productId })
                if let nonNilShopCart = managedShopCart {
                    nonNilShopCart.quantity = cart.quantity
                    self.store?.saveWithCompletionBlock(block: { response in
                        switch response {
                        case .success(_):block(.success(true))
                        case .failure(let error): block(.failure(error))
                        }
                    })
                } else {
                    let error = BPError.init(domain: BetaProduct.kBPErrorDomain, code: .Database, description: "Unable to find the Product", reason: BetaProduct.kBPGenericError, suggestion: "Debug function \(#function)")
                    block(.failure(error))
                }
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    private func ProductFromManagedProduct(product: ManagedProduct) -> Product {
        return Product.init(productName: product.name,
                            productDescription: product.productDescription,
                            productId: product.productId,
                            productPrice: product.price,
                            productPriceDescription: product.productDescription,
                            productWeblink: product.weblink,
                            productImageURL: product.imageUrl,
                            productImageThumbURL: product.imageThumbUrl,
                            productImageCompanyURL: product.imageCompanyUrl)
    }
    
    private func ShopCartFromManagedShopCart(cart: [ManagedShopCart]) -> [ShopCart] {
        let items = cart.map({ managedShopCart in
            return ShopCart.init(productId: managedShopCart.product.productId, quantity: managedShopCart.quantity, userId: managedShopCart.user.id, product: ProductFromManagedProduct(product: managedShopCart.product))
        })
        return items
    }
}
