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
        Alamofire.request(URL.init(string: url)!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {response in
            switch response.result {
            case .success(let value):
//                block(true, nil, value as? [Any])
//                let x =
                block(Response<[Any]>.success(value as! [Any]))
                
                let x = Response<[Any]>.failure(BPError())
                
            case .failure (let error):
//                block(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
//                                          code: BetaProductError.WebService.rawValue,
//                                          description: BetaProduct.kBetaProductGenericErrorDescription,
//                                          reason: error.localizedDescription,
//                                          suggestion: "Debug function \(#function)"), nil)
                let caughtError = Response<[Any]>.failure(BPError.init(domain: BetaProduct.kBetaProductErrorDomain,
                                                                       code: .WebService,
                                                                       description: BetaProduct.kBetaProductGenericErrorDescription,
                                                                       reason: error.localizedDescription,
                                                                       suggestion: "Debug function \(#function)"))
//                let caughtError = Response<[Any]>.failure(BPError.init(domain: "", code: BPE, description: error.localizedDescription, reason: "", suggestion: ""))
                caughtError.error?.innerError = error
                block(caughtError)
            }
        }
    }
    
    // TODO: PUT
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func PUT(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        
    }
    
    // TODO: POST
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func POST(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        
    }
    
    // TODO: DELETE
    /// Protocol implementation. see `StoreWebClientProtocol.swift`
    func DELETE(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlock<[Any]>) {
        
    }
}
