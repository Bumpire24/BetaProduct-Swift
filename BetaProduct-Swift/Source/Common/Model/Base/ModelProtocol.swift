//
//  ModelProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol ModelProtocol {
    var status : Int16 { get }
    var syncStatus : Int16 { get }
    var createdAt : Date { get }
    var modifiedAt : Date { get }
    var col1 : String { get }
    var col2 : String { get }
    var col3 : String { get }
}
