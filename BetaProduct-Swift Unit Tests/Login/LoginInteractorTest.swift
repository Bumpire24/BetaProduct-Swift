//
//  BetaProduct_SwiftTests.swift
//  BetaProduct-SwiftTests
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

/// test interactor class for module `login`
class LoginInteractorTest: XCTestCase, LogInInteractorOutput {
    /// variable for result. shared variable for class and delegate
    var result : (isSuccess : Bool, message : String) = (isSuccess : false, message : "")
    /// variable for interactor
    var interactor : LogInInteractor?
    /// variable for expectation
    var expectation : XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        interactor = LogInInteractor()
        interactor?.output = self
    }
    
    override func tearDown() {
        interactor = nil
        expectation = nil
        super.tearDown()
    }
    
    // use case
    // validateLogIn
    // retrieve user using given input
    // check username nil, username whitespace, username trim, valid email
    // check password nil, password whitespace, password trim
    // call WS
    // authenticate account
    // check if account exists in db
    // insert new record
    // Save User to Session
    
    /// tests login if email is nil
    func testUsernameNil() {
        let item = UserDisplayItem.init(email: nil, password: "pass")
        interactor?.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameNil Failed")
    }
    
    /// tests login if email has whitespaces
    func testUsernameWhiteSpace() {
        let item = UserDisplayItem.init(email: "    ", password: "pass")
        interactor?.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    /// tests login if email does not follow correct pattern
    func testUsernameIncorrectPattern() {
        let item = UserDisplayItem.init(email: "asd", password: "pass")
        interactor?.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameIncorrectPattern Failed")
    }

    /// tests login if password is nil
    func testPasswordNil() {
        let item = UserDisplayItem.init(email: "user@gmail.com", password: nil)
        interactor?.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordNil Failed")
    }
    
    /// tests login if password has whitespaces
    func testPasswordWhitespace() {
        let item = UserDisplayItem.init(email: "user@gmail.com", password: "  ")
        interactor?.validateUserLogin(userDisplayItem: item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordWhitespace Failed")
    }

    /// tests if account does not exist after attempting to log in
    func testRecordNotFound() {
        class MockWebservice : StoreWebClient {
            override func POST(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "No Record Found!", reason: "No Record Found!", suggestion: "")))
            }
        }
        
        self.expectation = expectation(description: "testRecordNotFound")
        let item = UserDisplayItem.init(email: "asd@gmail.com", password: "asd")
        interactor?.webService = MockWebservice()
        interactor?.validateUserLogin(userDisplayItem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }

    /// tests login succesful
    func testLoginSuccessful() {
        class MockWebservice : StoreWebClient {
            override func POST(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
        }
        
        class MockManagerLogin : LogInManager {
            override func retrieveUser(withEmail email : String, withCompletionBlock block : @escaping CompletionBlock<User>) {
                block(.success(User.init(emailAddress: "asd@gmail.com", password: "asd")))
            }
        }
        
        class MockSession : Session {
            override func setUserSessionByUser(_ user: User) {
                self.user = UserSession()
                self.user?.email = "asd@gmail.com"
                self.user?.password = "asd"
            }
        }
        
        self.expectation = expectation(description: "testLoginSuccessful")
        let item = UserDisplayItem.init(email: "asd@gmail.com", password: "asd")
        interactor?.managerLogin = MockManagerLogin()
        interactor?.webService = MockWebservice()
        interactor?.session = MockSession()
        interactor?.validateUserLogin(userDisplayItem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// LogInInteractorOutput protocol implementation
    func userLoginValidationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        result.isSuccess = isSuccess
        result.message = message
        if expectation != nil {
            if expectation?.description == "testRecordNotFound" {
                XCTAssert(self.result == (false, "No Record Found!"), "testRecordNotFound Failed")
            }
            if expectation?.description == "testLoginSuccessful" {
                XCTAssert(self.result == (true, "Log in success!"), "testLoginSuccessful Failed")
                XCTAssertNotNil(interactor?.session?.user, "testLoginSuccessful Failed")
            }
            expectation?.fulfill()
        }
    }
}
