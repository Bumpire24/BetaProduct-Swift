//
//  BetaProduct.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

enum BetaProductError : Int {
    case Database = 1,
    WebService,
    Business
}

struct BetaProductStyle {
    static var iDoohPink = UIColor(red:1.00, green:0.40, blue:0.82, alpha:1.0)
    static var iDoohPurple = UIColor(red:0.25, green:0.31, blue:0.49, alpha:1.0)
    static var iDoohHelveticaButtonLabel = UIFont(name: "Helvetica", size: 20)
}

class BetaProduct: NSObject {
    static let kBetaProductErrorDomain : String = "BetaProductErrorDomain"
    static let kBetaProductGenericErrorDescription : String = "Something went wrong"
    static let kBetaProductDatabaseName : String = "Something.sqlite"
    static let kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/"
    static let kBetaProductWSGetProductList : String = kBetaProductWebserviceURL + "photos"
}
