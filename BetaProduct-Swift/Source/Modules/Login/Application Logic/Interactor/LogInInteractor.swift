//
//  LogInInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation
import UIKit

class LogInInteractor: NSObject, LogInInteractorInput {
    var manager : LogInManager?
    var output : LogInInteractorOutput?
    
    func validateLogIn(_ loginDisplay: Any) {
        manager?.validateUser(User.init(), block: { x in
            if x.isSuccess {
                output?.loginSuccessful(true)
            }
            output?.loginSuccessful(false)
        })
    }
}
