//
//  ProductManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct Results<T> {
    let isSuccess : Bool
    var error : NSError?
    var results : Array<T>
}

class ProductManager: NSObject {
    private var retrievedConvertedProducts : [Product]?
    var store : StoreCoreData?
    
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
    
    func getPersistedProductById(_ index : Int) -> Product?{
        if let results = retrievedConvertedProducts {
            if results.count > 0 {
                return results[index]
            }
        }
        return nil
    }
    
    private func productsFromManagedProducts(_ entries : [ManagedProduct]) -> [Product] {
        var items : [Product] = []
        for managedProduct in entries {
            let product = Product(name : managedProduct.name,
                                  weblink : managedProduct.weblink,
                                  productDescription : managedProduct.productDescription,
                                  price : managedProduct.price,
                                  priceDescription : managedProduct.priceDescription,
                                  imageUrl : managedProduct.imageUrl,
                                  imageThumbUrl : managedProduct.imageThumbUrl,
                                  imageCompanyUrl : managedProduct.imageCompanyUrl,
                                  productId : managedProduct.productId,
                                  status : managedProduct.status,
                                  syncStatus : managedProduct.syncStatus,
                                  createdAt : managedProduct.createdAt,
                                  modifiedAt : managedProduct.modifiedAt,
                                  col1 : managedProduct.col1,
                                  col2 : managedProduct.col2,
                                  col3 : managedProduct.col3)
            items.append(product)
        }
        return items
    }
}
