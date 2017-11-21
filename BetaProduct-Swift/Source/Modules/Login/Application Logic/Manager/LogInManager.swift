//
//  LogInManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class LogInManager: NSObject {
    var store : StoreProtocol?
    var storeWS : StoreWebClientProtocol?
    
    func retrieveUser(withEmail email : String, andWithPassword password : String, withCompletionBlock block : @escaping CompletionBlock<User>) {
        let predicate = NSPredicate.init(format: "status != %d AND email == %@ AND password == %@", Status.Deleted.rawValue, email, password)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response{
            case .success(let result):
                block(Response.success(result?.first as? User))
                break
            case .failure(let caughtError):
                let error = BPError.init(domain: BetaProduct.kBPErrorDomain,
                                         code: .Business,
                                         description: "No Record Found!",
                                         reason: (caughtError?.localizedDescription)!,
                                         suggestion: (caughtError?.localizedRecoverySuggestion)!)
                error.innerBPError = caughtError
                block(Response.failure(error))
                break
            }
        })
    }
}
