//
//  WebServiceTest.swift
//  BetaProduct-Swift Unit Tests
//
//  Created by User on 11/27/17.
//  Copyright © 2017 User. All rights reserved.
//

import XCTest
@testable import BetaProduct_Swift_DEV

/// test service class for service `StoreWebClient`
class WebServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    /// test GET behavior
    func testGetFunctionality() {
        let expectation : XCTestExpectation = self.expectation(description: "testGetFunctionality")
        StoreWebClient().GET(BetaProduct.kBPWSGetUser, parameters: nil) { response in
            guard let data = response.value?.first, let datadict = data as? [String : Any?] else {
                XCTFail("testGetFunctionality failed")
                expectation.fulfill()
                return
            }
            
            XCTAssert(datadict["userId"] != nil, "testGetFunctionality failed")
            XCTAssert(datadict["id"] != nil, "testGetFunctionality failed")
            XCTAssert(datadict["title"] != nil, "testGetFunctionality failed")
            XCTAssert(datadict["body"] != nil, "testGetFunctionality failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0) { _ in
        }
    }
    
    /// test POST behavior
    func testPostFunctionality() {
        let expectation : XCTestExpectation = self.expectation(description: "testPostFunctionality")
        StoreWebClient().POST(BetaProduct.kBPWSPostUser, parameters: nil) { response in
            guard let data = response.value?.first, let datadict = data as? [String : Any?] else {
                XCTFail("testPostFunctionality failed")
                expectation.fulfill()
                return
            }
            
            XCTAssert(datadict["id"] != nil, "testPostFunctionality failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0) { _ in
        }
    }
    
    /// test PUT behavior
    func testPutFunctionality() {
        let expectation : XCTestExpectation = self.expectation(description: "testPutFunctionality")
        StoreWebClient().PUT(BetaProduct.kBPWSPutUserWithId("1"), parameters: nil) { response in
            guard let data = response.value?.first, let datadict = data as? [String : Any?] else {
                XCTFail("testPutFunctionality failed")
                expectation.fulfill()
                return
            }
            
            XCTAssert(datadict["id"] != nil, "testPutFunctionality failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0) { _ in
        }
    }
    
    /// test DELETE behavior
    func testDeleteFunctionality() {
        let expectation : XCTestExpectation = self.expectation(description: "testDeleteFunctionality")
        StoreWebClient().PUT(BetaProduct.kBPWSDeleteUserWithId("1"), parameters: nil) { response in
            guard let data = response.value?.first, let datadict = data as? [String : Any?] else {
                XCTFail("testDeleteFunctionality failed")
                expectation.fulfill()
                return
            }
            
            XCTAssert(datadict["id"] != nil, "testDeleteFunctionality failed")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0) { _ in
        }
    }
}
