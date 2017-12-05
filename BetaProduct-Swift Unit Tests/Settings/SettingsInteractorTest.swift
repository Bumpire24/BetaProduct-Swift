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
    /// variable for session
    var session: MockSession? = nil
    
    /// mock class for session
    class MockSession: Session {
        override init() {
            super.init()
            self.user = UserSession()
            self.user?.fullName = "sample"
            self.user?.addShipping = "sample"
            self.user?.mobile = "123456789"
            self.user?.imageURLProfile = "url"
            self.user?.email = "sample@gmail.com"
            self.user?.password = "sample"
        }
    }
    
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
        session = MockSession()
    }
    
    override func tearDown() {
        interactor = nil
        expectation = nil
        session = nil
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
        
        interactor?.session = session
        let item = SettingsProfileDisplayItem.init(name: "sample", mobile: "123456789", addressShipping: "sample", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "No changes found for Profile!", "testIfEntryhasnoChanges failed")
    }
    
    /// tests if photo upload and profile update fails in webservice
    func testProfileUpdateFailAndPhotoUploadFail() {
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
        interactor?.session = session
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if profile update fails in webservice and there is no photo to upload
    func testProfileUpdateFailAndNoPhotoUpload() {
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
        }
        
        expectation = expectation(description: "testProfileUpdateFailAndNoPhotoUpload")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: nil))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if profile update fails in webservice and photo upload is successful
    func testProfileUpdateFailAndPhotoUploadSucessful() {
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
        }
        
        class MockManager: SettingsManager {
            override func updateUser(user: User, withCompletionBlock block: @escaping (Response<Bool>) -> Void) {
                block(.success(nil))
            }
        }
        
        expectation = expectation(description: "testProfileUpdateFailAndPhotoUploadSucessful")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        interactor?.manager = MockManager()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if photo upload fails in webservice and No Profile to upload
    func testPhotoUploadFailAndNoProfileUpdate() {
        class MockWebservice : StoreWebClient {
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Update Failed!", reason: "Update Failed!", suggestion: "Update Failed!")))
            }
        }
        
        expectation = expectation(description: "testPhotoUploadFailAndNoProfileUpdate")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        let item = SettingsProfileDisplayItem.init(name: "sample", mobile: "123456789", addressShipping: "sample", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if photo upload fails in webservice and profile update successful
    func testPhotoUploadFailAndProfileUpdateSuccessful() {
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.failure(BPError.init(domain: "", code: .WebService, description: "Photo Upload Failed!", reason: "Photo Upload Failed!", suggestion: "Photo Upload Failed!")))
            }
        }
        
        class MockManager: SettingsManager {
            override func updateUser(user: User, withCompletionBlock block: @escaping (Response<Bool>) -> Void) {
                block(.success(nil))
            }
        }
        
        expectation = expectation(description: "testPhotoUploadFailAndProfileUpdateSuccessful")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        interactor?.manager = MockManager()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if profile and photo upload are both successful
    func testProfileUpadteSuccessfulAndPhotoUploadSuccessful() {
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
        }
        
        class MockManager: SettingsManager {
            override func updateUser(user: User, withCompletionBlock block: @escaping (Response<Bool>) -> Void) {
                block(.success(nil))
            }
        }
        
        expectation = expectation(description: "testProfileUpadteSuccessfulAndPhotoUploadSuccessful")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        interactor?.manager = MockManager()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    func testManagerFailsWhenPhotoAndProfileUpdateSuccessful() {
        class MockWebservice : StoreWebClient {
            override func PUT(_ url: String, parameters: [String : Any]?, block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
            
            override func UploadImage(asData data: Data, toURL url: String, WithCompletionBlock block: @escaping (Response<[Any]>) -> Void) {
                block(.success(nil))
            }
        }
        
        class MockManager: SettingsManager {
            override func updateUser(user: User, withCompletionBlock block: @escaping (Response<Bool>) -> Void) {
                block(.failure(nil))
            }
        }
        
        expectation = expectation(description: "testManagerFailsWhenPhotoAndProfileUpdateSuccessful")
        interactor?.session = session
        interactor?.webservice = MockWebservice()
        interactor?.manager = MockManager()
        let item = SettingsProfileDisplayItem.init(name: "samples", mobile: "123456789", addressShipping: "samples", profileImage: (url: "url", image: UIImage.init(named: "iDooh")))
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        self.waitForExpectations(timeout: 0.5) { _ in
        }
    }
    
    /// tests if Old Password matches Current Password
    func testOldPassMatchesCurrentPass() {
        let item = SettingsPasswordDisplayItem.init(passwordOld: "asd", passwordNew: "samples", passwordNewConfirm: "samples")
        interactor?.session = session
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Your Old Password does not match your Current Password", "testOldPassMatchesCurrentPass failed")
    }
    
    /// tests of New Password matches Confirm New Password
    func testNewPassMatchesConfirmPass() {
        let item = SettingsPasswordDisplayItem.init(passwordOld: "sample", passwordNew: "samples", passwordNewConfirm: "sample")
        interactor?.session = session
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "New Password and Confirm New Password does not match", "testNewPassMatchesConfirmPass failed")
    }
    
    /// tests if Old Email matches Current Email
    func testOldEmailMatchesCurrentEmail() {
        let item = SettingsEmailDisplayItem.init(emailAddOld: "asd@gmail.com", emailAddNew: "sample@gmail.com", emailAddNewConfirm: "sample@gmail.com")
        interactor?.session = session
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "Your Old Email does not match your Current Email", "testOldEmailMatchesCurrentEmail failed")
    }
    
    /// tests if New Email matches Confirm New Emai
    func testNewEmailMatchesConfirmEmail() {
        let item = SettingsEmailDisplayItem.init(emailAddOld: "sample@gmail.com", emailAddNew: "samples@gmail.com", emailAddNewConfirm: "sample@gmail.com")
        interactor?.session = session
        interactor?.validateAndUpdateSettings(usingDisplayitem: item)
        XCTAssert(result.isSuccess == false && result.message == "New Email and Confirm New Email does not match", "testNewEmailMatchesConfirmEmail failed")
    }
    
    /// tests logout
    func testLogout() {
        interactor?.session = session
        interactor?.logOut()
    }
    
    /// tests retrieve Session Data to be displayed
    func testGetViewModelForProfile() {
        interactor?.session = session
        interactor?.getDisplayItemForProfile()
    }
    
    // MARK: SettingsHomeInteractorOuput, SettingsProfileInteractorOutput, SettingsEmailInteractorOutput, SettingsPasswordInteractorOutput
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func logOutReady() {
        XCTAssertNil(session?.user, "testLogout failed")
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func gotDisplayItem(_ item: SettingsProfileDisplayItem) {
        XCTAssert(item.name == "sample" &&
                  item.mobile == "123456789" &&
                  item.addressShipping == "sample" &&
                  item.profileImage.url == "url", "testGetViewModelForProfile failed")
    }
    
    /// protocol implementation. see `SettingsInteractorIO.swift`
    func settingsUpdationComplete(wasSuccessful isSuccess: Bool, withMessage message: String) {
        result.isSuccess = isSuccess
        result.message = message
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
            
            if expectation?.description == "testProfileUpdateFailAndPhotoUploadSucessful" {
                XCTAssert(result.isSuccess == true && result.message == "Update Failed! Photo Upload successful!", "testProfileUpdateFailAndPhotoUploadSucessful failed")
                XCTAssert(result.displayItem.profileImage.url == "http://placehold.it/600/92c952", "testProfileUpdateFailAndPhotoUploadSucessful failed")
                XCTAssert(session?.user?.imageURLProfile == "http://placehold.it/600/92c952", "testProfileUpdateFailAndPhotoUploadSucessful failed")
            }
            
            if expectation?.description == "testPhotoUploadFailAndNoProfileUpload" {
                XCTAssert(result.isSuccess == false && result.message == "Profile Update Failed", "testPhotoUploadFailAndNoProfileUpdate failed")
            }
            
            if expectation?.description == "testPhotoUploadFailAndProfileUpdateSuccessful" {
                XCTAssert(result.isSuccess == true && result.message == "Profile Update successful! Photo Upload Failed!", "testPhotoUploadFailAndProfileUpdateSuccessful failed")
                XCTAssert(result.displayItem.name == "samples", "testPhotoUploadFailAndProfileUpdateSuccessful failed")
                XCTAssert(session?.user?.fullName == "samples", "testPhotoUploadFailAndProfileUpdateSuccessful failed")
            }
            
            if expectation?.description == "testProfileUpadteSuccessfulAndPhotoUploadSuccessful" {
                XCTAssert(result.isSuccess == true && result.message == "Profile Update successful! Photo Upload successful!", "testProfileUpadteSuccessfulAndPhotoUploadSuccessful failed")
                XCTAssert(result.displayItem.name == "samples", "testProfileUpadteSuccessfulAndPhotoUploadSuccessful failed")
                XCTAssert(session?.user?.fullName == "samples", "testProfileUpadteSuccessfulAndPhotoUploadSuccessful failed")
                XCTAssert(result.displayItem.profileImage.url == "http://placehold.it/600/92c952", "testProfileUpadteSuccessfulAndPhotoUploadSuccessful failed")
                XCTAssert(session?.user?.imageURLProfile == "http://placehold.it/600/92c952", "testProfileUpadteSuccessfulAndPhotoUploadSuccessful failed")
            }
            
            if expectation?.description == "testManagerFailsWhenPhotoAndProfileUpdateSuccessful" {
                XCTAssert(result.isSuccess == false && result.message == "Profile Update Failed", "testManagerFailsWhenPhotoAndProfileUpdateSuccessful failed")
            }
            
            expectation?.fulfill()
        }
    }
}
