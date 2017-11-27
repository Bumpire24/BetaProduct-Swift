//
//  CreateAccountInteractorTest.swift
//  BetaProduct-Swift Unit Tests
//
//  Created by User on 11/24/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

/// test interactor class for module `create account`
class CreateAccountInteractorTest: XCTestCase, CreateAccountInteractorOutput {
    /// variable for result. Shared variable for class and delegate
    var result : (isSuccess : Bool, message : String) = (isSuccess : false, message : "")
    /// variable for interactor
    var interactor : CreateAccountInteractor?
    /// variable for expectation
    var expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        interactor = CreateAccountInteractor()
        interactor?.output = self
    }
    
    override func tearDown() {
        interactor = nil
        expectation = nil
        super.tearDown()
    }
    
    // use case
    // validate Account Credentials
    // retrieve account with the given input
    // check email nil, email whitespace, valid email
    // check password nil, password whitespace
    // call WS
    // check account if valid for creation
    
    /// tests login if email is nil
    func testUsernameNil() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: nil, password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameNil Failed")
    }
    
    /// tests login if email has whitespaces
    func testUsernameWhiteSpace() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "  ", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    /// tests login if email does not follow correct pattern
    func testUsernameIncorrectPattern() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    // MARK: CreateAccountInteractorOutput
    /// protocol implementation CreateAccountInteractorOutput
    func createAccountSuccessful(_ wasSuccessful: Bool, message: String) {
        result.isSuccess = wasSuccessful
        result.message = message
        if expectation != nil {
            expectation?.fulfill()
        }
    }
}
