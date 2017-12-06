//
//  ProductManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class ProductManager: NSObject {
    var store : StoreCoreData?
    
    func createProduct(withProduct product: Product, withCompletionBlock block: @escaping CompletionBlock<Bool>) {
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
        store?.saveWithCompletionBlock(block: { response in
            switch response {
            case .success(_):
                block(.success(true))
            case .failure(let error):
                block(.failure(error))
            }
        })
    }
    
    func retrieveProducts(withCompletionBlock block: @escaping CompletionBlock<[Product]>) {
        store?.fetchEntries(withEntityName: "Product", withCompletionBlock: { response in
            switch response {
            case .success(let result):
                self.store?.fetchEntries(withEntityName: "User", withCompletionBlock: { response in
                    switch response {
                    case .success(let value):
                        let user = value?.first as! ManagedUser
                        user.products = Set<ManagedProduct>(result as! [ManagedProduct])
                        self.store?.save()
                    case .failure(let error):
                        block(.failure(error))
                    }
                })
            case .failure(let error): block(.failure(error))
            }
        })
    }
    
//    func retrieveProducts(withCompletionBlock block: @escaping CompletionBlock<[Product]>) {
//        store?.fetchEntries(withEntityName: "Product", withCompletionBlock: { response in
//            switch response {
//            case .success(let result): block(.success(self.productsFromManagedProducts(entries: result as! [ManagedProduct])))
//            case .failure(let error): block(.failure(error))
//            }
//        })
//    }
    
//    func sample(_ block : ((Results<Product>) -> Void)) {
//        let entityName = "Product"
//        let predicate = NSPredicate.init(format: "status != %d", SyncStatus.Deleted.rawValue)
//        store?.fetchEntries(withEntityName: entityName, withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { success, error, results in
//            if success {
//                if results!.count > 0 {
//                    let x = Response<Any>.success(BPError.init(domain: "", code: .Database, description: "", reason: "", suggestion: ""))
//                } else {
//                    let x = Response<Any>.failure(BPError.init(domain: "", code: .Database, description: "", reason: "", suggestion: ""))
//                }
//            } else {
//                let x = Response<Any>.failure(BPError.init(domain: "", code: .Database, description: "", reason: "", suggestion: ""))
//                x.error?.innerNSError = error
//            }
//        })
//    }
    
//    func sample(_ block : CompletionBlock1<[Product]>) {
//        let entityName = "Product"
//        let predicate = NSPredicate.init(format: "status != %d", SyncStatus.Deleted.rawValue)
//        store?.fetchEntries(withEntityName: entityName, withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { success, error, results in
//            if success {
//                if results!.count > 0 {
//
//                } else {
//
//                }
//            } else {
//
//            }
//        })
//    }
    
//    func getProducts(_ block : @escaping CompletionBlockWithResults) {
//        let entityName = "Product"
//        let predicate = NSPredicate.init(format: "status != %d", SyncStatus.Deleted.rawValue)
//        store?.fetchEntries(withEntityName: entityName, withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { success, error, results in
//            if success {
//                if results!.count > 0 {
//                    block(success, nil, self.productsFromManagedProducts(results as! [ManagedProduct]))
//                } else {
//                    block(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
//                                              code: BetaProductError.Database.rawValue,
//                                              description: "Found No Records",
//                                              reason: "No Records found for entity \(entityName)",
//                        suggestion: "debug function func \(#function)"),nil)
//                }
//            } else {
//                block(success, error, results)
//            }
//        })
//    }
    
    private func productsFromManagedProducts(entries : [ManagedProduct]) -> [Product] {
        var items : [Product] = []
        for managedProduct in entries {
            items.append(Product(status : managedProduct.status,
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
                                 productId : managedProduct.productId))
        }
        return items
    }
}
