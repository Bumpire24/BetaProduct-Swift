//
//  ShopCart.swift
//  BetaProduct-Swift
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct ShopCart: ModelProtocol {
    var status: Int16 = Status.Active.toInt16()
    var syncStatus: Int16 = SyncStatus.Created.toInt16()
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    var col1: String = ""
    var col2: String = ""
    var col3: String = ""
    var quantity: Int16 = 1
    var productId: Int16 = -1
    var userId: Int16 = -1
}

extension ShopCart {
    init(productId: Int16, quantity: Int16, userId: Int16) {
        self.productId = productId
        self.quantity = quantity
        self.userId = userId
    }
}
