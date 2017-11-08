//
//  Product+CoreDataProperties.swift
//  
//
//  Created by User on 11/8/17.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var col1: String?
    @NSManaged public var col2: String?
    @NSManaged public var col3: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var imageCompanyUrl: String?
    @NSManaged public var imageThumbUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var modifiedAt: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var priceDescription: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productId: Int16?
    @NSManaged public var status: NSNumber?
    @NSManaged public var syncStatus: NSNumber?
    @NSManaged public var weblink: String?

}
