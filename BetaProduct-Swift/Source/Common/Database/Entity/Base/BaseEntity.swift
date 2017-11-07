//
//  BaseEntity.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import CoreData

class BaseEntity: NSManagedObject {
    @NSManaged var createdAt : Date
    @NSManaged var modifiedAt : Date
    @NSManaged var status : Int16
    @NSManaged var syncStatus : Int16
    @NSManaged var col1 : String
    @NSManaged var col2 : String
    @NSManaged var col3 : String
}
