//
//  QRCodeWireframe.swift
//  BetaProduct-Swift
//
//  Created by Enrico Boller on 20/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

let qrViewIdentifier = "QRView"

class QRCodeWireframe: BaseWireframe, HomeTabBarInterface {
    var qrCodeView : QRCodeView?
    
    func configuredViewController(_ viewController: HomeView) -> UIViewController {
        let qrCodeViewControl = qrCodeViewController()
        qrCodeViewControl.tabBarItem = UITabBarItem.init(title: "QR Code Scanner", image: UIImage.init(imageLiteralResourceName: "qr"), tag: 1)
        return qrCodeViewControl
    }
    
    func presentQRViewFromViewController(_ viewController: UIViewController) {
        let newViewController = qrCodeViewController()
        qrCodeView = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func qrCodeViewController() -> QRCodeView {
        let viewcontroller = mainStoryBoard().instantiateViewController(withIdentifier: qrViewIdentifier) as! QRCodeView
        return viewcontroller
    }
}
