//
//  SyncEngine.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class SyncEngine: NSObject {
    let storeCD : StoreCoreData = StoreCoreData()
    let storeWC : StoreWebClient = StoreWebClient()
    
    func startInitialSync(_ block : @escaping CompletionBlock){
        storeWC.GET(BetaProduct.kBetaProductWSGetProductList, parameters: nil) { success, error, results in
            if success {
                let downloadGroup = DispatchGroup()
                for data in results! {
                    let product : Product = self.storeCD.newProduct()
                    let dataDict : [String : Any] = data as! [String : Any]
                    product.productId = dataDict["id"] as! Int16
                    product.name = dataDict["title"] as! String
                    product.productDescription = dataDict["thumbnailUrl"] as! String
                    product.priceDescription = dataDict["thumbnailUrl"] as! String
                    product.imageUrl = dataDict["url"] as! String
                    product.imageThumbUrl = dataDict["thumbnailUrl"] as! String
                    product.status = Int16(Status.Active.rawValue)
                    product.syncStatus = Int16(SyncStatus.Synced.rawValue)
                    product.createdAt = Date()
                    product.modifiedAt = Date()
                    downloadGroup.enter()
                    self.storeCD.saveWithCompletionBlock(block: { (success, error) in
                        if (!success) {
                            
                        }
                        downloadGroup.leave()
                    })
                }
                downloadGroup.notify(queue: .main, execute: {
                    block(true, nil)
                })
            } else {
               block(false, error)
            }
        }
    }
}
