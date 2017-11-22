//
//  BaseView.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class BaseView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //applyGradientBackground()
        applyBlurredWatermark()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func applyGradientBackground() {
        let gradientView = UIView(frame: self.view.bounds)
        var gradientLayer: CAGradientLayer!
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [BetaProductStyle.Colors.iDoohPink.cgColor, BetaProductStyle.Colors.iDoohPurple.cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        self.view.insertSubview(gradientView, at: 0)
    }
    
    func applyImageWatermark() -> UIImageView {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "launchImage.png")
        backgroundImage.contentMode = .scaleAspectFill
        //self.view.insertSubview(backgroundImage, at: 0)
        
        return backgroundImage
    }
    
    func applyBlurredWatermark() {
        let coverImageView = applyImageWatermark()
        let effect = UIBlurEffect(style: .extraLight)
        let overlayView = UIVisualEffectView(effect: effect)
        overlayView.frame = self.view.bounds
        overlayView.center = self.view.center
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        //self.view.insertSubview(overlayView, aboveSubview: coverImageView)
        //self.view.insertSubview(overlayView, at: 0)
        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: effect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(coverImageView)
        //self.view.insertSubview(overlayView, aboveSubview: coverImageView)
        self.view.insertSubview(overlayView, at: 0)
    }
}
