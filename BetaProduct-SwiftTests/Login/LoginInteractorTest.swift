//
//  BetaProduct_SwiftTests.swift
//  BetaProduct-SwiftTests
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

class LoginInteractorTest: XCTestCase, LogInInteractorOutput {
    var result : (isSuccess : Bool, message : String) = (isSuccess : false, message : "")
    var interactor = LogInInteractor()
    var expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        interactor.output = self
    }
    
    override func tearDown() {
        expectation = nil
        super.tearDown()
    }
    
    //validateLogIn
    // check username nil, username has char
    // check password nil, password has char
    // check record exists
    // retrieve user using given input
    
    func testUsernameNil() {
        let item = UserDisplayItem.init(username: nil, password: "pass")
        interactor.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameNil Failed")
    }
    
    func testUsernameWhiteSpace() {
        let item = UserDisplayItem.init(username: "", password: "pass")
        interactor.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }

    func testPasswordNil() {
        let item = UserDisplayItem.init(username: "user", password: nil)
        interactor.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordNil Failed")
    }

    func testPasswordWhitespace() {
        let item = UserDisplayItem.init(username: "user", password: "")
        interactor.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordWhitespace Failed")
    }

    func testRecordNotFound() {
        class MockManager : LogInManager {
            override func retrieveUser(withEmail email: String, andWithPassword password: String, withCompletionBlock block: (Response<User?>) -> Void) {
                block(Response.failure(BPError.init(domain: "", code: .Business, description: "No Record Found!", reason: "No Record Found!", suggestion: "")))
            }
        }
        self.expectation = expectation(description: "testRecordNotFound")
        let item = UserDisplayItem.init(username: "asd", password: "asd")
        interactor.manager = MockManager()
        interactor.validateUserLogin(userDisplayItem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }

    func testLoginSuccessful() {
        class MockManager : LogInManager {
            override func retrieveUser(withEmail email: String, andWithPassword password: String, withCompletionBlock block: (Response<User?>) -> Void) {
                block(Response.success(User.init(emailAddress: "sample", password: "sample")))
            }
        }
        self.expectation = expectation(description: "testLoginSuccessful")
        let item = UserDisplayItem.init(username: "sample", password: "sample")
        interactor.manager = MockManager()
        interactor.validateUserLogin(userDisplayItem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        result.isSuccess = isSuccess
        result.message = message
        if expectation != nil {
            if expectation?.description == "testRecordNotFound" {
                XCTAssert(self.result == (false, "No Record Found!"), "testRecordNotFound Failed")
            }
            if expectation?.description == "testLoginSuccessful" {
                XCTAssert(self.result == (true, "Log In success!"), "testLoginSuccessful Failed")
            }
            expectation?.fulfill()
        }
    }
}
