//
//  CompletionBlockTypes.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T?)
    case failure(BPError?)
    
    var isSuccess : Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    public var error: BPError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

typealias CompletionBlock<T> = (Response<T>) -> Void

