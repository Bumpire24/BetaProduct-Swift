//
//  StoreWebClient.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import Alamofire

/// class implementation for StoreWebClientProtocol. see `StoreWebClientProtocol.swift`
class StoreWebClient: StoreWebClientProtocol {
    // MARK: StoreWebClientProtocol
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func GET(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .get, parameters: parameters, block: block)
    }
    
    // TODO: PUT
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func PUT(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .put, parameters: parameters, block: block)
    }
    
    // TODO: POST
    /// Protocol implementation. see `StoreWebClientProtocol.swift` 
    func POST(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .post, parameters: parameters, block: block)
    }
    
    // TODO: DELETE
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func DELETE(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .delete, parameters: parameters, block: block)
    }
    
    // MARK: Privates
    /**
     calls webservice via Alamofire
     - Parameters:
         - url: url target
         - method: HTTP Method
         - parameters: Parameters attached, in Dictionary format [String: Any]
         - block: completion closure. Follows Response Class
     */
    private func callWS(_ url: String, method: HTTPMethod, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        print("CALL URL: \(url) with parameters: \(String(describing: parameters))")
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if let rawdata = response.data, let processeddata = String(data: rawdata, encoding: .utf8) {
                print(processeddata)
            }
            switch response.result {
            case .success(let value):
                if let result = value as? [Any] {
                    block(.success(result))
                } else if let result = value as? [String: Any] {
                    block(.success([result]))
                } else {
                    block(.success(nil))
                }
            case .failure(let error):
                let caughtError = BPError.init(domain: BetaProduct.kBPErrorDomain,
                                               code: .WebService,
                                               description: BetaProduct.kBPGenericError,
                                               reason: error.localizedDescription,
                                               suggestion: "Debug function \(#function)")
                caughtError.innerError = error
                block(.failure(caughtError))
            }
        }
    }
}
