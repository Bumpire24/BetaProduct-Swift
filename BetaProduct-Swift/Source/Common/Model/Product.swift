//
//  Product.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct Product : ModelProtocol {
    var status: Int16 = Status.Active.toInt16()
    var syncStatus: Int16 = SyncStatus.Created.toInt16()
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    var col1: String = ""
    var col2: String = ""
    var col3: String = ""
    var name: String = ""
    var weblink: String = ""
    var productDescription: String = ""
    var price: Double = 0.00
    var priceDescription: String = ""
    var imageUrl: String = ""
    var imageThumbUrl: String = ""
    var imageCompanyUrl: String = ""
    var productId: Int16 = -1
    var productAddedInCart: Bool = false
}

extension Product {
    init(productName: String,
         productDescription: String,
         productId: Int16,
         productPrice: Double,
         productPriceDescription: String,
         productWeblink: String,
         productImageURL: String,
         productImageThumbURL: String,
         productImageCompanyURL: String) {
        self.name = productName
        self.productDescription = productDescription
        self.productId = productId
        self.price = productPrice
        self.priceDescription = productPriceDescription
        self.weblink = productWeblink
        self.imageUrl = productImageURL
        self.imageThumbUrl = productImageThumbURL
        self.imageCompanyUrl = productImageCompanyURL
    }
    
    init(dictionary dataDict: [String: Any]) {
        let wsConverter = WebServiceConverter.init(dataDict)
        self.name = wsConverter.stringWithKey("name")
        self.productDescription = wsConverter.stringWithKey("description")
        self.productId = wsConverter.int16WithKey("id")
        self.price = wsConverter.doubleWithKey("price")
        self.priceDescription = wsConverter.stringWithKey("currency")
        self.weblink = wsConverter.stringWithKey("url")
        self.imageUrl = wsConverter.stringWithKey("image_high_res_url")
        self.imageThumbUrl = wsConverter.stringWithKey("image_thumbnail_url")
        self.imageCompanyUrl = wsConverter.stringWithKey("image_thumbnail_url")
    }
}
