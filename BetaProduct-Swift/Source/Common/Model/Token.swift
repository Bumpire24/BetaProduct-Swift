//
//  Session.swift
//  BetaProduct-Swift
//
//  Created by User on 12/14/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct Token {
    var tokenType: String = ""
    var accessToken: String = ""
    var expiresIn: Int16 = 0
    var userId: Int16 = -1
}

extension Token {
    init(dictionary dataDict: [String: Any]) {
        let wsConverter = WebServiceConverter.init(dataDict)
        self.tokenType = wsConverter.stringWithKey("token_type")
        self.accessToken = wsConverter.stringWithKey("access_token")
        self.expiresIn = wsConverter.int16WithKey("expires_in")
        self.userId = wsConverter.int16WithKey("user_id")
    }
}
