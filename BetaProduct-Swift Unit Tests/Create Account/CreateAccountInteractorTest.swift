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
    
    /// tests create account if email is nil
    func testUsernameNil() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: nil, password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameNil Failed")
    }
    
    /// tests create account if email has whitespaces
    func testUsernameWhiteSpace() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "  ", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    /// tests create account if email does not follow correct pattern
    func testUsernameIncorrectPattern() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    /// tests create account if password is empty
    func testPasswordNil() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample@gmail.com", password: nil)
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordNil Failed")
    }
    
    /// tests create account if pasword has white spaces
    func testPasswordWhiteSpace() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample@gmail.com", password: "    ")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordWhiteSpace Failed")
    }
    
    /// tests create account if mobile is nil
    func testMobileNil() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: nil, email: "sample@gmail.com", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Mobile Number incorrect!"), "testMobileNil Failed")
    }
    
    /// tests create account if mobile has whitespaces
    func testMobileWhiteSpace() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: " ", email: " sample@gmail.com", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Mobile Number incorrect!"), "testMobileWhiteSpace Failed")
    }
    
    /// tests create account if mobile does not follow correct pattern
    func testMobileIncorrectPattern() {
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "123", email: "sample@gmail.com", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Mobile Number incorrect!"), "testMobileIncorrectPattern Failed")
    }
    
    /// tests create account if full name is empty
    func testNameNil() {
        let item = UserCredentialsItem.init(fullName: nil, mobileNumber: "12345678", email: "sample@gmail.com", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Full Name incorrect!"), "testNameNil Failed")
    }
    
    /// tests create account if full name has white spaces
    func testNameWhiteSpace() {
        let item = UserCredentialsItem.init(fullName: " ", mobileNumber: "12345678", email: "sample@gmail.com", password: "sample")
        interactor?.validateAccountCredentials(item)
        XCTAssert(result == (false, "Full Name incorrect!"), "testNameWhiteSpace Failed")
    }
    
    /// tests if account already exists
    func testAccountDuplicate() {
        class MockWebservice : StoreWebClient {
            override func POST(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Existing Account!", reason: "Existing Account!", suggestion: "Existing Account!")))
            }
        }
        
        self.expectation = expectation(description: "testAccountDuplicate")
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample@gmail.com", password: "sample")
        interactor?.webService = MockWebservice()
        interactor?.validateAccountCredentials(item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if account creation successful
    func testAccountCreationSuccess() {
        class MockWebservice : StoreWebClient {
            override func POST(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.success([]))
            }
        }
        
        self.expectation = expectation(description: "testAccountCreationSuccess")
        let item = UserCredentialsItem.init(fullName: "Sample", mobileNumber: "12345678", email: "sample@gmail.com", password: "sample")
        interactor?.webService = MockWebservice()
        interactor?.validateAccountCredentials(item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    // MARK: CreateAccountInteractorOutput
    /// protocol implementation CreateAccountInteractorOutput
    func createAccountSuccessful(_ wasSuccessful: Bool, message: String) {
        result.isSuccess = wasSuccessful
        result.message = message
        if expectation != nil {
            if expectation?.description == "testAccountDuplicate" {
                XCTAssert(result == (false, "Existing Account!"), "testAccountDuplicate Failed")
            }
            if expectation?.description == "testAccountCreationSuccess" {
                XCTAssert(result == (true, "Account creation Successful!"), "testAccountCreationSuccess Failed")
            }
            expectation?.fulfill()
        }
    }
}
