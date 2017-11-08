//
//  StoreCoreData.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import CoreData

class StoreCoreData: NSObject, StoreProtocol{
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    var managedObjectModel : NSManagedObjectModel!
    var managedObjectContext : NSManagedObjectContext!
    
    override init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent(BetaProduct.kBetaProductDatabaseName)
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
    }
    
    func fetchEntries(withEntityName entityName : String, withCompletionBlock completionBlock : @escaping CompletionBlockWithResults) -> Void {
        fetchEntries(withEntityName: entityName, withCompletionBlock: completionBlock);
    }
    
    func fetchEntries(withEntityName entityName : String, withPredicate predicate : NSPredicate?, withSortDescriptors sortDescriptors : [NSSortDescriptor]?, withCompletionBlock completionBlock : @escaping CompletionBlockWithResults) -> Void {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        managedObjectContext.perform {
            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
            if let results = queryResults {
                if results.count == 0 {
                    completionBlock(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
                                                        code: BetaProductError.Database.rawValue,
                                                        description: BetaProduct.kBetaProductGenericErrorDescription,
                                                        reason: "Found Empty Records for entity \(entityName)",
                                                        suggestion: "Debug function \(#function)"), nil)
                } else {
                    completionBlock(true, nil, results)
                }
            } else {
                completionBlock(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
                                                    code: BetaProductError.Database.rawValue,
                                                    description: BetaProduct.kBetaProductGenericErrorDescription,
                                                    reason: "Encountered an error in Core Data during when fetching",
                                                    suggestion: "Debug function \(#function)"), nil)
            }
        }
    }
    
    func newProduct() -> Product {
//        let entityDescription : NSEntityDescription = NSEntityDescription.entity(forEntityName: "Product", in: managedObjectContext)!
//        let product : Product = NSManagedObject.init(entity: entityDescription, insertInto: managedObjectContext) as! Product
//        return product
//
        let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Product", into: managedObjectContext) as! Product
        return newEntry
    }
    
    func deleteProduct(product: Product) {
        managedObjectContext.delete(product)
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch _ {
            
        }
    }
    
    func saveOrRollBack() {
        do {
            try managedObjectContext.save()
        } catch _ {
            managedObjectContext.rollback()
        }
    }
    
    func saveWithCompletionBlock(block: CompletionBlock) {
        do {
            try managedObjectContext.save()
            block(true, nil)
        } catch let caughtError {
            let error = NSError.init(domain: BetaProduct.kBetaProductErrorDomain, code:BetaProductError.Database.rawValue, description: BetaProduct.kBetaProductGenericErrorDescription, reason: caughtError.localizedDescription, suggestion: "Debug save function")
            block(false, error)
        }
    }
    
    func saveOrRollBackWithCompletionBlock(block: CompletionBlock) {
        do {
            try managedObjectContext.save()
            block(true, nil)
        } catch let caughtError {
            managedObjectContext.rollback()
            let error = NSError.init(domain: BetaProduct.kBetaProductErrorDomain, code:BetaProductError.Database.rawValue, description: BetaProduct.kBetaProductGenericErrorDescription, reason: caughtError.localizedDescription, suggestion: "Debug save function")
            block(false, error)
        }
    }
}
