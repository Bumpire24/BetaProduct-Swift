//
//  Error+Utility.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

extension NSError {
    convenience init(domain : String, code : Int, description : String, reason : String, suggestion : String) {
        let userInfo = [
            NSLocalizedDescriptionKey : description,
            NSLocalizedFailureReasonErrorKey : reason,
            NSLocalizedRecoverySuggestionErrorKey : suggestion
        ]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}
