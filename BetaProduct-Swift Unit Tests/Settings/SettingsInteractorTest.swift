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
class SettingsInteractorTest: XCTestCase, SettingsHomeInteractorOuput, SettingsProfileInteractorOutput, SettingsEmailInteractorOutput, SettingsPasswordInteractorOutput {
    /// variable for result. shared variable for class and delegate
    var result: (isSuccess : Bool, message : String, displayItem : SettingsProfileDisplayItem) = (false, "", SettingsProfileDisplayItem())
    /// variable for interactor
    var interactor : SettingsInteractor?
    /// variable for expectation
    var expectation : XCTestExpectation? = nil
    
    // use case
    // retrieve data from session for display
    // handles log out by emptying session
    // handles user updates WS and core data
    //  * Profile Image Update
    //  * Profile Update
    //  * Password Change With new password cofirmation
    //  * Email Change
    // check if updation is valid
    // provide new update and update display
    
    override func setUp() {
        super.setUp()
        interactor = SettingsInteractor()
        interactor?.outputHome = self
        interactor?.outputProfile = self
        interactor?.outputEmail = self
        interactor?.outputPassword = self
    }
    
    override func tearDown() {
        interactor = nil
        expectation = nil
        super.tearDown()
    }
    
    /// tests if input name is null
    func testNameIsNil() {
        let item = SettingsProfileDisplayItem.init(name: nil, mobile: "123456789", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Name Incorrect!", "testNameIsNil failed")
    }
    
    /// tests if input name is empty
    func testNameIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "", mobile: "123456789", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Name Incorrect!", "testNameIsEmpty failed")
    }
    
    /// tests if input mobile is null
    func testMobileIsNil() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: nil, addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!", "testMobileIsNil failed")
    }
    
    /// tests if input mobile is empty
    func testMobileIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!", "testMobileIsEmpty failed")
    }
    
    /// tests if mobile is a valid phone number
    func testMobileIsValid() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "sample", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!", "testMobileIsValid failed")
    }
    
    /// tests if input address is null
    func testAddIsNil() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "123456789", addressShipping: nil, profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Address Incorrect!", "testAddIsNil failed")
    }
    
    /// tests if input addess is empty
    func testAddIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "123456789", addressShipping: "", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Address Incorrect!", "testAddIsEmpty failed")
    }
    
    /// tests if there was no change made in the item
    func testIfEntryhasnoChanges() {
        class MockSession: Session {
            override init() {
                super.init()
                self.user = UserSession()
                self.user?.fullName = "sample"
                self.user?.addShipping = "sample"
                self.user?.mobile = "123456789"
                self.user?.imageURLProfile = "url"
            }
        }
        
        interactor?.session = MockSession()
        let item = SettingsProfileDisplayItem.init(name: "sample", mobile: "123456789", addressShipping: "sample", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "No changes found for Profile!", "testIfEntryhasnoChanges failed")
    }
    
    /// tests if photo upload and profile update fails in webservice
    func testProfileUpdateFailAndPhotoUploadFail() {
        class MockSession: Session {
            override init() {
                super.init()
                self.user = UserSession()
                self.user?.fullName = "sample"
                self.user?.addShipping = "sample"
                self.user?.mobile = "123456789"
                self.user?.imageURLProfile = "url"
            }
        }
        
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
        }
        
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "sample", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        expectation = expectation(description: "testProfileUpdateFailAndPhotoUploadFail")
        interactor?.webservice = MockWebservice()
        interactor?.session = MockSession()
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if profile update fails in webservice and there is no photo to upload
    func testProfileUpdateFailAndNoPhotoUpload() {
        class MockSession: Session {
            override init() {
                super.init()
                self.user = UserSession()
                self.user?.fullName = "sample"
                self.user?.addShipping = "sample"
                self.user?.mobile = "123456789"
                self.user?.imageURLProfile = "url"
            }
        }
        
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
        }
        
        expectation = expectation(description: "testProfileUpdateFailAndNoPhotoUpload")
        interactor?.session = MockSession()
        interactor?.webservice = MockWebservice()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    func testProfileUpdateFailAndPhotoUploadSuccess() {
        class MockSession: Session {
            override init() {
                super.init()
                self.user = UserSession()
                self.user?.fullName = "sample"
                self.user?.addShipping = "sample"
                self.user?.mobile = "123456789"
                self.user?.imageURLProfile = "url"
            }
        }
        
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
        }
        
        //"http://placehold.it/600/92c952"
    }
    
    // MARK: SettingsHomeInteractorOuput, SettingsProfileInteractorOutput, SettingsEmailInteractorOutput, SettingsPasswordInteractorOutput
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func logOutReady() {
        
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func gotDisplayItem(_ item: SettingsProfileDisplayItem) {
        
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func settingsUpdationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func settingsUpdationComplete(wasSuccessful isSuccess: Bool, withMessage message: String, withNewDisplayItem displayItem: SettingsProfileDisplayItem) {
        result.isSuccess = isSuccess
        result.message = message
        result.displayItem = displayItem
        if expectation != nil {
            if expectation?.description == "testProfileUpdateFailAndPhotoUploadFail" {
                XCTAssert(result.isSuccess == false && result.message == "Profile Update Failed", "testPhotoUploadFailAndProfileUpdateFail failed")
            }
            
            if expectation?.description == "testProfileUpdateFailAndNoPhotoUpload" {
                XCTAssert(result.isSuccess == false && result.message == "Profile Update Failed", "testProfileUpdateFailAndNoPhotoUpload failed")
            }
            expectation?.fulfill()
        }
    }
}
