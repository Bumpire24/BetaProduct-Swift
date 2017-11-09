//
//  CompletionBlockTypes.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

typealias CompletionBlock = (_ isSuccesful: Bool, _ error: NSError?) -> Void
typealias CompletionBlockWithResults = (_ isSuccesful: Bool, _ error: NSError?, _ results : [Any]?) -> Void
typealias CompletionBlockWithResult<T> = (_ isSuccesful : Bool, _ error: NSError?, _ result :T) -> Void
