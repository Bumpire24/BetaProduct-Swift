//
//  BetaProductError.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

enum BPErrorCode : Int {
    case Database = 1000,
    WebService,
    Business
}

class BPError: NSError {
    var errorCode : BPErrorCode?
    var innerError : Error?
    var innerNSError : NSError?
    var innerBPError : BPError?
    
    convenience init(domain : String, code : BPErrorCode, description : String, reason : String, suggestion : String) {
        let userInfo = [
            NSLocalizedDescriptionKey : description,
            NSLocalizedFailureReasonErrorKey : reason,
            NSLocalizedRecoverySuggestionErrorKey : suggestion
        ]
        self.init(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
}
