//
//  BetaProduct_SwiftTests.swift
//  BetaProduct-SwiftTests
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

class BetaProduct_SwiftTests: XCTestCase, LogInInteractorOutput {
    var result : (Bool, String) = (false, "")
    var presenter = LogInPresenter()
    var interactor = LogInInteractor()
    var manager = LogInManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor.output = self
        interactor.manager = manager
        presenter.interactor = interactor
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //validateLogIn
    // check username nil, username has char
    // check password nil, password has char
    // check record exists
    // retrieve user using given input
    
    func testUsernameNil() {
        let item = UserDisplayItem.init(username: nil, password: "pass")
        presenter.validateUser(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameNil Failed")
    }
    
    func testUsernameWhiteSpace() {
        let item = UserDisplayItem.init(username: "", password: "pass")
        presenter.validateUser(item)
        XCTAssert(result == (false, "Username incorrect!"), "testUsernameWhiteSpace Failed")
    }
    
    func testPasswordNil() {
        let item = UserDisplayItem.init(username: "user", password: nil)
        presenter.validateUser(item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordNil Failed")
    }
    
    func testPasswordWhitespace() {
        let item = UserDisplayItem.init(username: "user", password: "")
        presenter.validateUser(item)
        XCTAssert(result == (false, "Password incorrect!"), "testPasswordWhitespace Failed")
    }
    
    func testRecordNotFound() {
        let item = UserDisplayItem.init(username: "asd", password: "asd")
        presenter.validateUser(item)
        XCTAssert(result == (false, "No Record Found!"), "testRecordNotFound Failed")
    }
    
    func testLoginSuccessful() {
        let item = UserDisplayItem.init(username: "sample", password: "sample")
        presenter.validateUser(item)
        XCTAssert(result == (true, "Log In success!"), "testLoginSuccessful failed")
    }
    
    func loginSuccessful(_ wasSuccessful: Bool, message: String) {
        result.0 = wasSuccessful
        result.1 = message
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
