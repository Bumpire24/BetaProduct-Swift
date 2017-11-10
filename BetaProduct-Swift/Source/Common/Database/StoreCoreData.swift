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
    /// variable for PersistentStoreCoordinator. Core Data Element.
    var persistentStoreCoordinator : NSPersistentStoreCoordinator!
    /// variable for NSManagedObjectModel. Core Data Element.
    var managedObjectModel : NSManagedObjectModel!
    /// variable for NSManagedObjectContext. Core Data Element.
    var managedObjectContext : NSManagedObjectContext!
    
    /**
     Overrides init. Setup of configuration for Core Data Elements
     */
    override init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: directory, in: domains).first!
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent(BetaProduct.kBetaProductDatabaseName)
        
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.undoManager = nil
        
        super.init()
    }
    
    // MARK: StoreProtocol
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func fetchEntries(withEntityName entityName : String, withCompletionBlock completionBlock : @escaping CompletionBlock<[Any]>) -> Void {
        fetchEntries(withEntityName: entityName, withCompletionBlock: completionBlock);
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func fetchEntries(withEntityName entityName : String, withPredicate predicate : NSPredicate?, withSortDescriptors sortDescriptors : [NSSortDescriptor]?, withCompletionBlock completionBlock : @escaping CompletionBlock<[Any]>) -> Void {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
//        managedObjectContext.perform {
//            let queryResults = try? self.managedObjectContext.fetch(fetchRequest)
//            if let results = queryResults {
//                if results.count == 0 {
//                    completionBlock(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
//                                                        code: BetaProductError.Database.rawValue,
//                                                        description: BetaProduct.kBetaProductGenericErrorDescription,
//                                                        reason: "Found Empty Records for entity \(entityName)",
//                                                        suggestion: "Debug function \(#function)"), nil)
//                } else {
//                    completionBlock(true, nil, results)
//                }
//            } else {
//                completionBlock(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
//                                                    code: BetaProductError.Database.rawValue,
//                                                    description: BetaProduct.kBetaProductGenericErrorDescription,
//                                                    reason: "Encountered an error in Core Data during when fetching",
//                                                    suggestion: "Debug function \(#function)"), nil)
//            }
//        }
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func newProduct() -> ManagedProduct {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: managedObjectContext)
        let newEntry = NSManagedObject.init(entity: entityDescription!, insertInto: managedObjectContext) as! ManagedProduct
        return newEntry
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func deleteProduct(product: ManagedProduct) {
        managedObjectContext.delete(product)
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func save() {
        do {
            try managedObjectContext.save()
        } catch _ {
            
        }
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func saveOrRollBack() {
        do {
            try managedObjectContext.save()
        } catch _ {
            managedObjectContext.rollback()
        }
    }
    
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func saveWithCompletionBlock(block: CompletionBlock<Bool>) {
//        do {
//            try managedObjectContext.save()
//            block(true, nil)
//        } catch let caughtError {
//            let error = NSError.init(domain: BetaProduct.kBetaProductErrorDomain, code:BetaProductError.Database.rawValue, description: BetaProduct.kBetaProductGenericErrorDescription, reason: caughtError.localizedDescription, suggestion: "Debug save function")
//            block(false, error)
//        }
    }
    
    /// Protocol implementation. see `StoreProtocol.swift`
    func saveOrRollBackWithCompletionBlock(block: CompletionBlock<Bool>) {
//        do {
//            try managedObjectContext.save()
//            block(true, nil)
//        } catch let caughtError {
//            managedObjectContext.rollback()
//            let error = NSError.init(domain: BetaProduct.kBetaProductErrorDomain, code:BetaProductError.Database.rawValue, description: BetaProduct.kBetaProductGenericErrorDescription, reason: caughtError.localizedDescription, suggestion: "Debug save function")
//            block(false, error)
//        }
    }
}
