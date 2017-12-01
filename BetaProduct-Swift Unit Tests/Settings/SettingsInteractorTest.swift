//
//  SettingsInteractorTest.swift
//  BetaProduct-Swift Unit Tests
//
//  Created by User on 11/29/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

/// test interactor class for module `Settings`
class SettingsInteractorTest: XCTestCase, SettingsPhotoUploadInteractorOutput, SettingsHomeInteractorOuput, SettingsProfileInteractorOutput, SettingsEmailInteractorOutput, SettingsPasswordInteractorOutput {
    /// variable for result. shared variable for class and delegate
    var result : (isSuccess : Bool, message : String) = (isSuccess : false, message : "")
    /// variable for interactor
    var interactor : LogInInteractor?
    /// variable for expectation
    var expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func logOutReady() {
        
    }
    
    func gotDisplayItem(_ item: SettingsProfileDisplayItem) {
        
    }
    
    func settingsUpdationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        
    }
    
    func settingsUpdationComplete<T>(wasSuccessful isSuccess: Bool, withMessage message: String, withNewDisplayItem displayItem: T) where T : SettingsDisplayItemProtocol {
        
    }
}
