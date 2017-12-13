//
//  WebServiceConverter.swift
//  BetaProduct-Swift
//
//  Created by User on 11/9/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import CocoaLumberjack

class WebServiceConverter {
    var dataDict = Dictionary<String, Any>()
    
    convenience init(_ dictionary : Dictionary<String, Any>) {
        self.init()
        dataDict = dictionary
    }
    
    private func logErrorKeyNotFound(_ key : String) {
        let error : BPError = BPError.init(domain: BetaProduct.kBPErrorDomain,
                                           code: .WebService,
                                           description: "Unable to convert data dictionary",
                                           reason: "\(key) does not exist in dictionary",
                                           suggestion: "debug function \(#function)")
        DDLogError("Error  description : \(error.localizedDescription) reason : \(error.localizedFailureReason ?? "Unknown Reason") suggestion : \(error.localizedRecoverySuggestion ?? "Unknown Suggestion")")
    }
    
    private func logErrorKeyIsNotTheExpectedType<T>(_ key : String, value : T) {
        let error : BPError = BPError.init(domain: BetaProduct.kBPErrorDomain,
                                           code: .WebService,
                                           description: "Unable to convert data dictionary",
                                           reason: "\(key) does not follow correct Type \(String(describing: type(of: value)))",
                                           suggestion: "debug function \(#function)")
        DDLogError("Error  description : \(error.localizedDescription) reason : \(error.localizedFailureReason ?? "Unknown Reason") suggestion : \(error.localizedRecoverySuggestion ?? "Unknown Suggestion")")
    }
    
    func stringWithKey(_ key : String) -> String {
        var value = ""
        if dataDict[key] != nil {
            value = dataDict[key] as! String
        } else {
            logErrorKeyNotFound(key)
        }
        return value
    }
    
    func dateWithKey(_ key : String) -> Date {
        var value : Date = Date()
        if dataDict[key] != nil {
            value = dataDict[key] as! Date
        } else {
            logErrorKeyNotFound(key)
        }
        return value
    }
    
    func int16WithKey(_ key : String) -> Int16 {
        var value : Int16 = -1
        if dataDict[key] != nil {
            if let x = dataDict[key] as! Int16? {
                value = x
            } else {
                logErrorKeyIsNotTheExpectedType(key, value: value)
            }
        } else {
            logErrorKeyNotFound(key)
        }
        return value
    }
    
    func decimalWithKey(_ key: String) -> Decimal {
        var value : Decimal = 0.00
        if dataDict[key] != nil {
            if let x = dataDict[key] as! Decimal? {
                value = x
            } else {
                logErrorKeyIsNotTheExpectedType(key, value: value)
            }
        } else {
            logErrorKeyNotFound(key)
        }
        return value
    }
    
    func floatWithKey(_ key: String) -> Float {
        var value : Float = 0.00
        if dataDict[key] != nil {
            if let x = dataDict[key] as! Float? {
                value = x
            } else {
                logErrorKeyIsNotTheExpectedType(key, value: value)
            }
        } else {
            logErrorKeyNotFound(key)
        }
        return value
    }
}
