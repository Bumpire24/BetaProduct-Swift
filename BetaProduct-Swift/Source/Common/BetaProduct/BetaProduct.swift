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

struct BetaProduct {
    static let kBetaProductErrorDomain : String = "BetaProductErrorDomain"
    static let kBetaProductGenericErrorDescription : String = "Something went wrong"
    static let kBetaProductDatabaseName : String = "Something.sqlite"
    static var kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/"
    static let kBetaProductWSGetProductList : String = kBetaProductWebserviceURL + "photos"
//    #if DEV
//    static var kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/"
//    #elseif QA
//    static var kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/QA"
//    #elseif PROD
//    static var kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/PROD"
//    #endif
}
