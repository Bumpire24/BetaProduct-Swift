//
//  ProductManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ProductManager: NSObject {
    var store : StoreProtocol?
    private var responseBlockCreate: CompletionBlock<Bool>?
    
    func createProduct(withProducts products: [Product], WithUser user: User, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "status != %d AND email == %@", Status.Deleted.rawValue, user.email)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate,
                            withSortDescriptors: nil,
                            withCompletionBlock: { response in
                                switch response {
                                case .success(let value):
                                    let managedUser = value?.first as! ManagedUser
                                    
                                    for product in products {
                                        let newProduct = self.store?.newProduct()
                                        newProduct?.name = product.name
                                        newProduct?.productDescription = product.productDescription
                                        newProduct?.price = product.price
                                        newProduct?.priceDescription = product.priceDescription
                                        newProduct?.weblink = product.weblink
                                        newProduct?.productId = product.productId
                                        newProduct?.imageUrl = product.imageUrl
                                        newProduct?.imageThumbUrl = product.imageThumbUrl
                                        newProduct?.imageCompanyUrl = product.imageCompanyUrl
                                        newProduct?.createdAt = product.createdAt
                                        newProduct?.modifiedAt = product.modifiedAt
                                        newProduct?.status = product.status
                                        newProduct?.syncStatus = product.syncStatus
                                        newProduct?.addUser(user: managedUser)
                                    }
                                    
                                    self.store?.saveWithCompletionBlock(block: { response in
                                        switch response {
                                        case .success(_):
                                            block(.success(true))
                                        case .failure(let error):
                                            block(.failure(error))
                                        }
                                    })
                                    
                                case .failure(let error):
                                    block(.failure(error))
                                }
        })
    }
    
    func createProduct(withProduct product: Product, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        self.createProduct(withProduct: product, WithUser: nil, withCompletionBlock: block)
    }
    
    func createProduct(withProduct product: Product, WithUser user: User?, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        responseBlockCreate = block
        
        let newProduct = store?.newProduct()
        newProduct?.name = product.name
        newProduct?.productDescription = product.productDescription
        newProduct?.price = product.price
        newProduct?.priceDescription = product.priceDescription
        newProduct?.weblink = product.weblink
        newProduct?.productId = product.productId
        newProduct?.imageUrl = product.imageUrl
        newProduct?.imageThumbUrl = product.imageThumbUrl
        newProduct?.imageCompanyUrl = product.imageCompanyUrl
        newProduct?.createdAt = product.createdAt
        newProduct?.modifiedAt = product.modifiedAt
        newProduct?.status = product.status
        newProduct?.syncStatus = product.syncStatus
        
        if let targetUser = user {
            let predicate = NSPredicate.init(format: "status != %d AND email == %@", Status.Deleted.rawValue, targetUser.email)
            store?.fetchEntries(withEntityName: "User", withPredicate: predicate,
                                withSortDescriptors: nil,
                                withCompletionBlock: { response in
                                    switch response {
                                    case .success(let value):
                                        let managedUser = value?.first as! ManagedUser
                                        self.processProductCreation(withUser: managedUser, withProduct: newProduct)
                                    case .failure(_):
                                        self.processProductCreation(withUser: nil, withProduct: newProduct)
                                    }
            })
        } else {
            processProductCreation(withUser: nil, withProduct: newProduct)
        }
    }
    
    func retrieveProducts(withCompletionBlock block: @escaping CompletionBlock<[Product]>) {
        store?.fetchEntries(withEntityName: "Product", withCompletionBlock: { response in
            switch response {
            case .success(let value): block(.success(self.productsFromManagedProducts(entries: value!.map { $0 as! ManagedProduct })))
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
    func retrieveProducts(withUser user: User, withCompletionBlock block: @escaping CompletionBlock<[Product]>) {
        let predicate = NSPredicate.init(format: "status != %d AND email == %@", Status.Deleted.rawValue, user.email)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate,
                            withSortDescriptors: nil,
                            withCompletionBlock: { response in
                                switch response {
                                case .success(let value):
                                    let managedUser = value?.first as! ManagedUser
                                    block(.success(self.productsFromManagedProducts(entries: managedUser.products.map{$0 as! ManagedProduct})))
                                case .failure(let error): block(.failure(error))
                                }
        })
    }
    
    func updateProduct(product: Product, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "productId == %d", product.productId)
        store?.fetchEntries(withEntityName: "Product",
                            withPredicate: predicate,
                            withSortDescriptors: nil,
                            withCompletionBlock: { response in
                                switch response {
                                case .success(let value):
                                    let managedProduct = value!.first as! ManagedProduct
                                    managedProduct.imageCompanyUrl = product.imageCompanyUrl
                                    managedProduct.imageUrl = product.imageUrl
                                    managedProduct.imageThumbUrl = product.imageThumbUrl
                                    managedProduct.name = product.name
                                    managedProduct.productDescription = product.productDescription
                                    managedProduct.price = product.price
                                    managedProduct.priceDescription = product.priceDescription
                                    managedProduct.productId = product.productId
                                    managedProduct.weblink = product.weblink
                                    self.store?.saveWithCompletionBlock(block: { response in
                                        switch response {
                                        case .success(_): block(.success(true))
                                        case .failure(let error): block(.failure(error))
                                        }
                                    })
                                case .failure(let error):
                                    block(.failure(error))
                                }
        })
    }
    
    func deleteProduct(product: Product, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
        let predicate = NSPredicate.init(format: "productId == %d", product.productId)
        store?.fetchEntries(withEntityName: "Product",
                            withPredicate: predicate,
                            withSortDescriptors: nil,
                            withCompletionBlock: { response in
                                switch response {
                                case .success(let value):
                                    let managedProduct = value!.first as! ManagedProduct
                                    self.store?.deleteProduct(product: managedProduct)
                                    self.store?.saveWithCompletionBlock(block: { response in
                                        switch response {
                                        case .success(_): block(.success(true))
                                        case .failure(let error): block(.failure(error))
                                        }
                                    })
                                case .failure(let error):
                                    block(.failure(error))
                                }
        })
    }
    
    private func productsFromManagedProducts(entries : [ManagedProduct]) -> [Product] {
        let items = entries.map { managedProduct in
            return Product(status : managedProduct.status,
                           syncStatus : managedProduct.syncStatus,
                           createdAt : managedProduct.createdAt,
                           modifiedAt : managedProduct.modifiedAt,
                           col1 : managedProduct.col1,
                           col2 : managedProduct.col2,
                           col3 : managedProduct.col3,
                           name : managedProduct.name,
                           weblink : managedProduct.weblink,
                           productDescription : managedProduct.productDescription,
                           price : managedProduct.price,
                           priceDescription : managedProduct.priceDescription,
                           imageUrl : managedProduct.imageUrl,
                           imageThumbUrl : managedProduct.imageThumbUrl,
                           imageCompanyUrl : managedProduct.imageCompanyUrl,
                           productId : managedProduct.productId,
                           productAddedInCart : managedProduct.shopcart.count > 0)
        }
        return items
    }
    
    private func processProductCreation(withUser user: ManagedUser?, withProduct product: ManagedProduct?) {
        if let userBind = user {
            product?.addUser(user: userBind)
        }
        
        store?.saveWithCompletionBlock(block: { response in
            switch response {
            case .success(_):
                responseBlockCreate!(.success(true))
            case .failure(let error):
                responseBlockCreate!(.failure(error))
            }
        })
    }
}
