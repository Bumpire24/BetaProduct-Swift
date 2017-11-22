//
//  BetaProductError.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

public enum BPErrorCode : Int {
    case Database = 1000,
    WebService,
    Business
}

public class BPError: NSError {
    public var errorCode : BPErrorCode?
    public var innerError : Error?
    public var innerNSError : NSError?
    public var innerBPError : BPError?
    
    convenience init(domain : String, code : BPErrorCode, description : String, reason : String, suggestion : String) {
        let userInfo = [
            NSLocalizedDescriptionKey : description,
            NSLocalizedFailureReasonErrorKey : reason,
            NSLocalizedRecoverySuggestionErrorKey : suggestion
        ]
        self.init(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
}
