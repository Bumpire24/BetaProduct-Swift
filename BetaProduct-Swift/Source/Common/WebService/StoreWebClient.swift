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
    func GET(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlockWithResults) {
        Alamofire.request(URL.init(string: url)!, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {response in
            switch response.result {
            case .success (let value):
                block(true, nil, value as? [Any])
            case .failure (let error):
                block(false, NSError.init(domain: BetaProduct.kBetaProductErrorDomain,
                                          code: BetaProductError.WebService.rawValue,
                                          description: BetaProduct.kBetaProductGenericErrorDescription,
                                          reason: error.localizedDescription,
                                          suggestion: "Debug function \(#function)"), nil)
            }
        }
    }
    
    func PUT(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlockWithResults) {
        
    }
    
    func POST(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlockWithResults) {
        
    }
    
    func DELETE(_ url: String, parameters: [String : Any]?, block: @escaping CompletionBlockWithResults) {
        
    }
}
