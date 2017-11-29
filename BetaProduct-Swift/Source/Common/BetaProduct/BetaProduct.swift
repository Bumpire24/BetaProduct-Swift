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
    fileprivate struct Colors {
        static var iDoohPink = UIColor(red:1.00, green:0.40, blue:0.82, alpha:1.0)
        static var iDoohPurple = UIColor(red:0.25, green:0.31, blue:0.49, alpha:1.0)
        static var iDoohLightGrey = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0)
        static var iDoohLinkBlue = UIColor(red:0.00, green:0.52, blue:0.98, alpha:1.0)
        static var iDoohWhite = UIColor.white
        static var iDoohShadowColor = UIColor(red:0.39, green:0.0, blue:0.0, alpha:1.0)
        static var iDoohClearColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.0)
    }
    
    struct Fonts {
        static var iDoohButtonLabelFont = UIFont(name: "BloggerSans-Medium", size: 20)
        static var iDoohButtonLinkFont = UIFont(name: "BloggerSans-Medium", size: 20)
        static var iDoohTextfieldFont = UIFont(name: "BloggerSans-BoldItalic", size: 15)
        static var iDoohHeaderLabelFont = UIFont(name: "BloggerSans-Bold", size: 30)
        static var iDoohInstructionLabelFont = UIFont(name: "BloggerSans-LightItalic", size: 20)
        static var iDoohSettingsLabelFont = UIFont(name: "BloggerSans-Light", size: 20)
    }
    
    static var iDoohLinkColor = BetaProductStyle.Colors.iDoohLinkBlue
    static var iDoohClearBackground = BetaProductStyle.Colors.iDoohClearColor
    static var iDoohMessageViewBorderColor = BetaProductStyle.Colors.iDoohPurple
    static var iDoohMessageViewShadowColor = BetaProductStyle.Colors.iDoohShadowColor
    static var iDoohGradientColor1 = BetaProductStyle.Colors.iDoohPink
    static var iDoohGradientColor2 = BetaProductStyle.Colors.iDoohPurple
    static var iDoohPinkMainColor = BetaProductStyle.Colors.iDoohPink
    static var iDoohPurpleMainColor = BetaProductStyle.Colors.iDoohPurple
    static var iDoohLabelFontColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohTextFieldFontColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohTextFieldBorderColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohButtonFontColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohPrimaryButtonBackgroundColor = BetaProductStyle.Colors.iDoohPink
    static var iDoohPrimaryButtonBorderColor = BetaProductStyle.Colors.iDoohPurple
    static var iDoohSecondaryButtonBackgroundColor = BetaProductStyle.Colors.iDoohPurple
    static var iDoohSecondaryButtonBorderColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohTertiaryButtonBackgroundColor = BetaProductStyle.Colors.iDoohLightGrey
    static var iDoohTertiaryButtonBorderColor = BetaProductStyle.Colors.iDoohWhite
    static var iDoohLinkButtonFontColor = BetaProductStyle.Colors.iDoohPurple
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
    
    /// const for Webservice call : Get Users.
    static let kBPWSGetUser : String = kBPWS + "posts"
    
    /// const for Webservice call : Get Products.
    static let kBPWSGetProduct : String = kBPWS + "photos"
    
    /// const for Webservice call : Make User.
    static let kBPWSPostUser : String = kBPWS + "posts"
    
    /// const for Webservice call : Upload Image for User.
    static let kBPWSPostUserImage : String = kBPWS + "posts"
    
    /// const for Webservice call : Update User.
    static func kBPWSPutUserWithId(_ id : String) -> String {
        return kBPWS + "posts/" + id
    }
    
    /// const for Webservice call : Delete User.
    static func kBPWSDeleteUserWithId(_ id : String) -> String {
        return kBPWS + "posts/" + id
    }
}
