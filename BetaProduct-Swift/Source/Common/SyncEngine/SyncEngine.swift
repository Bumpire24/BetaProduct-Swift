//
//  SyncEngine.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import CocoaLumberjack

class SyncEngine: NSObject {
    /// variable For StoreCoreData
    let storeCD : StoreCoreData = StoreCoreData()
    /// variable For StoreWebClient
    let storeWC : StoreWebClient = StoreWebClient()
    
    /**
     Performs initial synchronization of webservice db and local db
    - Parameters:
        - block: Callback closure. see `CompletionBlockTypes.swift`
     */
    func startInitialSync(_ block : @escaping CompletionBlock<[Any]>){
//        storeWC.GET(BetaProduct.kBetaProductWSGetProductList, parameters: nil) { success, error, results in
//            if success {
//                let downloadGroup = DispatchGroup()
//                for data in results! {
//                    let product : ManagedProduct = self.storeCD.newProduct()
//                    let dataDict : [String : Any] = data as! [String : Any]
//                    let wsConverter = WebServiceConverter.init(dataDict)
//                    product.productId = wsConverter.int16WithKey("id")
//                    product.name = wsConverter.stringWithKey("body")
//                    product.productDescription = wsConverter.stringWithKey("thumbnailUrl")
//                    product.priceDescription = wsConverter.stringWithKey("thumbnailUrl")
//                    product.imageUrl = wsConverter.stringWithKey("url")
//                    product.imageThumbUrl = wsConverter.stringWithKey("thumbnailUrl")
//                    product.status = Int16(Status.Active.rawValue)
//                    product.syncStatus = Int16(SyncStatus.Synced.rawValue)
//                    product.createdAt = Date()
//                    product.modifiedAt = Date()
//                    downloadGroup.enter()
//                    self.storeCD.saveWithCompletionBlock(block: { success, error in
//                        if (!success) {
//                            DDLogError("Error  description : \(error?.localizedDescription ?? "Unknown Description") reason : \(error?.localizedFailureReason ?? "Unknown Reason") suggestion : \(error?.localizedRecoverySuggestion ?? "Unknown Suggestion")")
//                        }
//                        downloadGroup.leave()
//                    })
//                }
//                downloadGroup.notify(queue: .main, execute: {
//                    block(true, nil)
//                })
//            } else {
//                DDLogError("Error  description : \(error?.localizedDescription ?? "Unknown Description") reason : \(error?.localizedFailureReason ?? "Unknown Reason") suggestion : \(error?.localizedRecoverySuggestion ?? "Unknown Suggestion")")
//                block(false, error)
//            }
//        }
//
//        storeWC.GET("", parameters: nil) { result in
//
//        }
    }
    
    func syncCreatedAccount(_ block : @escaping CompletionBlock<Bool>) {
        print("Calling WS : \(BetaProduct.kBPWSPostUser)")
        let predicate = NSPredicate.init(format: "syncStatus == %d", SyncStatus.Created.rawValue)
        storeCD.fetchEntries(withEntityName: "User",
                             withPredicate: predicate,
                             withSortDescriptors: nil) { response in
                                switch response {
                                case .success(let value):
                                    let user = value?.first as! ManagedUser
                                    let params = ["email": user.email, "password": user.password, "fullname": user.fullname, "mobile": user.mobile]
                                    self.storeWC.POST(BetaProduct.kBPWSPostUser, parameters: params, block: { response in
                                        switch response {
                                        case .success(_):
                                            block(.success(true))
                                        case .failure(_):
                                            block(.failure(nil))
                                        }
                                    })
                                case .failure(let error):
                                    block(.failure(error))
                                }
        }
    }
}
