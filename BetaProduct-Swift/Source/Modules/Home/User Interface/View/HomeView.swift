//
//  HomeView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/7/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class HomeView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        insertSettingsButton()
//        let sync : SyncEngine = SyncEngine()
//        sync.startInitialSync { (success, error) in
//            print("BOOL : \(success) ERROR : \(error)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func insertSettingsButton() {
        let settingsImage = UIImage(named: "settings.png")
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(redirectToSettings))
        self.navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func redirectToSettings() {
        
    }

}
