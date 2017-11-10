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
    let name:               String
    let weblink:            String
    let productDescription: String
    let price:              String
    let priceDescription:   String
    let imageUrl:           String
    let imageThumbUrl:      String
    let imageCompanyUrl:    String
    let productId:          Int16
    let status:             Int16
    let syncStatus:         Int16
    let createdAt:          Date
    let modifiedAt:         Date
    let col1:               String
    let col2:               String
    let col3:               String
}
