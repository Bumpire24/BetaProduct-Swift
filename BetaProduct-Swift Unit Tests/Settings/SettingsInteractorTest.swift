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
    var result : (isSuccess : Bool, message : String, displayItem : SettingsDisplayItemProtocol?) = (false, "", nil)
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
        XCTAssert(result.isSuccess == false && result.message == "Name Incorrect!" && result.displayItem == nil, "testNameIsNil failed")
    }
    
    /// tests if input name is empty
    func testNameIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "", mobile: "123456789", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Name Incorrect!" && result.displayItem == nil, "testNameIsEmpty failed")
    }
    
    /// tests if input mobile is null
    func testMobileIsNil() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: nil, addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!" && result.displayItem == nil, "testMobileIsNil failed")
    }
    
    /// tests if input mobile is empty
    func testMobileIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!" && result.displayItem == nil, "testMobileIsEmpty failed")
    }
    
    /// tests if mobile is a valid phone number
    func testMobileIsValid() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "sample", addressShipping: "address", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Mobile Incorrect!" && result.displayItem == nil, "testMobileIsValid failed")
    }
    
    /// tests if input address is null
    func testAddIsNil() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "123456789", addressShipping: nil, profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Address Incorrect!" && result.displayItem == nil, "testAddIsNil failed")
    }
    
    /// tests if input addess is empty
    func testAddIsEmpty() {
        let item = SettingsProfileDisplayItem.init(name: "Sample", mobile: "123456789", addressShipping: "", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Address Incorrect!" && result.displayItem == nil, "testAddIsEmpty failed")
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
        XCTAssert(result.isSuccess == false && result.message == "No changes found for Profile!" && result.displayItem == nil, "testIfEntryhasnoChanges failed")
    }
    
    /// tests if photo upload and profile update fails in webservice
    func testPhotoUploadFailAndProfileUpdateFail() {
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
        
        interactor?.session = MockSession()
        interactor?.webservice = MockWebservice()
        let item = SettingsProfileDisplayItem.init(name: "sample", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Update Failed!" && result.displayItem == nil, "testProfileUpdateFailAndNoPhotoUpload failed")
    }
    
    /// tests if profile update fails in webservice and photo upload also fails
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
                block(.failure(BPError.init(domain: "", code: .WebService, description: "", reason: "", suggestion: "")))
            }
        }
        
        interactor?.session = MockSession()
        interactor?.webservice = MockWebservice()
        let item = SettingsProfileDisplayItem.init(name: "sample", mobile: "123456789", addressShipping: "sample", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Photo Upload failed Update Failed!" && result.displayItem == nil, "testProfileUpdateFailAndNoPhotoUpload failed")
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
    func settingsUpdationComplete<T>(wasSuccessful isSuccess: Bool, withMessage message: String, withNewDisplayItem displayItem: T?) where T : SettingsDisplayItemProtocol {
        result.isSuccess = isSuccess
        result.message = message
        result.displayItem = displayItem
    }
}
