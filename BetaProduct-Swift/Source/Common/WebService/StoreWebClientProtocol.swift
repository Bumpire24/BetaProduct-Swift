//
//  StoreWebClientProtocol.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

protocol StoreWebClientProtocol {
    func GET(_ url : String, parameters : [String : Any]?, block : @escaping CompletionBlockWithResults)
    func PUT(_ url : String, parameters : [String : Any]?, block : @escaping CompletionBlockWithResults)
    func POST(_ url : String, parameters : [String : Any]?, block : @escaping CompletionBlockWithResults)
    func DELETE(_ url : String, parameters : [String : Any]?, block : @escaping CompletionBlockWithResults)
}
