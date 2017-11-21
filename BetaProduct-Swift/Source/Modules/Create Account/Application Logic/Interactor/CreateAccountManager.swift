//
//  CreateAccountManager.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 11/17/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

class CreateAccountManager : NSObject {
    var store: StoreProtocol?
    private let syncEngine = SyncEngine()
    
    func createAccount(withUser user : User, withCompletionBlock block : @escaping CompletionBlock<Bool>) {
        let newUser = store?.newUser()
        newUser?.email = user.email
        newUser?.password = user.password
        newUser?.fullname = user.fullname
        newUser?.mobile = user.mobile
        newUser?.syncStatus = Int16(SyncStatus.Created.rawValue)
        store?.saveWithCompletionBlock(block: { response in
            switch response {
            case .success(_):
                syncEngine.syncCreatedAccount({ response in
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
}
