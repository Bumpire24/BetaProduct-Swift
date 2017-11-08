//
//  StoreProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol StoreProtocol {
    func fetchEntries(withEntityName entityName : String, withCompletionBlock block : @escaping CompletionBlockWithResults)
    func fetchEntries(withEntityName entityName : String,
                        withPredicate predicate : NSPredicate?,
            withSortDescriptors sortDescriptors : [NSSortDescriptor]?,
            withCompletionBlock block : @escaping CompletionBlockWithResults)
    func newProduct() -> Product
    func deleteProduct(product : Product)
    func save()
    func saveOrRollBack()
    func saveWithCompletionBlock(block : CompletionBlock)
    func saveOrRollBackWithCompletionBlock(block : CompletionBlock)
}
