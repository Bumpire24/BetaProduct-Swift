//
//  ShopCartDisplayItem.swift
//  BetaProduct-Swift
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

struct ShopCartListDisplayItem {
    var totalPrice: String?
    var items: [ShopCartDetailDisplayItem]?
}

struct ShopCartDetailDisplayItem {
    var productId: Int16?
    var productName: String?
    var productDescription: String?
    var productPrice: String?
    var productQuantity: String?
    var productImageURL: String?
}
