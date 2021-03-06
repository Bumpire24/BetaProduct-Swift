//
//  LogInManager.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

/// manager class for module `Login`
class LogInManager: NSObject {
    /// variable for store
    var store : StoreProtocol?
    
    /**
     retrieves User with given inputs
     - Parameters:
        - email: email input
        - password: password input
        - block: completion closure. Follows Response class
     */
    func retrieveUser(withEmail email : String, withCompletionBlock block : @escaping CompletionBlock<User>) {
        let predicate = NSPredicate.init(format: "status != %d AND email == %@", Status.Deleted.rawValue, email)
        store?.fetchEntries(withEntityName: "User", withPredicate: predicate, withSortDescriptors: nil, withCompletionBlock: { response in
            switch response {
            case .success(let result):
                let user = result?.first as! ManagedUser
                block(Response.success(User.init(withUserID: user.id,
                                                 withEmailAddress: user.email,
                                                 withLastName: user.lastName,
                                                 withFirstName: user.firstName,
                                                 withMiddleName: user.middleName,
                                                 withAddressShipping: user.addressShipping)))
                break
            case .failure(let caughtError):
                let error = BPError.init(domain: BetaProduct.kBPErrorDomain,
                                         code: .Business,
                                         description: (caughtError?.localizedDescription)!,
                                         reason: "No Record Found!",
                                         suggestion: (caughtError?.localizedRecoverySuggestion)!)
                error.innerBPError = caughtError
                block(Response.failure(error))
                break
            }
        })
    }
}
