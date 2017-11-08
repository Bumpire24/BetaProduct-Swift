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

class BetaProduct: NSObject {
    static let kBetaProductErrorDomain : String = "BetaProductErrorDomain"
    static let kBetaProductGenericErrorDescription : String = "Something went wrong"
    static let kBetaProductDatabaseName : String = "Something.sqlite"
    static let kBetaProductWebserviceURL : String = "http://jsonplaceholder.typicode.com/"
    static let kBetaProductWSGetProductList : String = kBetaProductWebserviceURL + "photos"
}
