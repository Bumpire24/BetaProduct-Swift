//
//  BetaProduct.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

struct BetaProductStyle {
    static var iDoohPink = UIColor(red:1.00, green:0.40, blue:0.82, alpha:1.0)
    static var iDoohPurple = UIColor(red:0.25, green:0.31, blue:0.49, alpha:1.0)
    static var iDoohLightGrey = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0)
    static var iDoohShadowColor = UIColor(red:0.39, green:0.0, blue:0.0, alpha:1.0)
    static var iDoohClearColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.0)
    static var iDoohLinkColor = UIColor(red:0.00, green:0.52, blue:0.98, alpha:1.0)
    static var iDoohButtonLabelFont = UIFont(name: "System", size: 30)
    static var iDoohButtonLinkFont = UIFont(name: "System", size: 30)
    static var iDoohTextfieldFont = UIFont(name: "System", size: 5)
}

/// Struct for Constants and Configs of Project Beta
struct BetaProduct {
    /// const for custom Error Domain
    static let kBPErrorDomain : String = "BetaProductErrorDomain"
    
    /// const for custom Generic Error Description
    static let kBPGenericError : String = "Something went wrong"
    
    /// const for Database Name
    static let kBPDBname : String = "bp.sqlite"
    
    /// const for main Webservice call. Retrieves from a plist file
    static var kBPWS : String {
        get {
            if let configFile = Bundle.main.infoDictionary, let url = configFile["BP_CONFIG_WS_URL"] {
                return url as! String
            } else {
                return "http://jsonplaceholder.typicode.com/"
            }
        }
    }
    
    /// const for Webservice call : Get Products.
    static let kBPWSGetProduct : String = kBPWS + "photos"
    
    /// const for Webservice call : Make User.
    static let kBPWSPostUser : String = kBPWS + "posts"
}
