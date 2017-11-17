//
//  Product.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/**
 
 */

struct Product : ModelProtocol {
    var status: Int16
    var syncStatus: Int16
    var createdAt: Date
    var modifiedAt: Date
    var col1: String
    var col2: String
    var col3: String
    let name:               String
    let weblink:            String
    let productDescription: String
    let price:              String
    let priceDescription:   String
    let imageUrl:           String
    let imageThumbUrl:      String
    let imageCompanyUrl:    String
    let productId:          Int16
}
