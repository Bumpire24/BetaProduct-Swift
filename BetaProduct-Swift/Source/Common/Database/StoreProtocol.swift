//
//  StoreProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol StoreProtocol {
    func fetchEntries(withEntityName entityName : String, withCompletionBlock completionBlock : @escaping CompletionBlockWithResults) -> Void
    func fetchEntries(withEntityName entityName : String,
                        withPredicate predicate : NSPredicate?,
            withSortDescriptors sortDescriptors : [NSSortDescriptor]?,
            withCompletionBlock completionBlock : @escaping CompletionBlockWithResults) -> Void
}
