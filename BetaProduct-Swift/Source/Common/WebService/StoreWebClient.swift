//
//  StoreWebClient.swift
//  BetaProduct-Swift
//
//  Created by User on 11/8/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import Alamofire

class StoreWebClient: StoreWebClientProtocol {
    // MARK: StoreWebClientProtocol
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func GET(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .get, parameters: parameters, block: block)
    }
    
    // TODO: PUT
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func PUT(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        
    }
    
    // TODO: POST
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func POST(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        callWS(url, method: .post, parameters: parameters, block: block)
    }
    
    // TODO: DELETE
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func DELETE(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        
    }
    
    private func callWS(_ url: String, method: HTTPMethod, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                block(.success(value as? [Any]))
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
