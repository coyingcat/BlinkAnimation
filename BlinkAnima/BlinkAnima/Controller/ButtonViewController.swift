//
//  ButtonViewController.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 2015/12/13.
//  Copyright © 2015年 CocoaPods. All rights reserved.
//

import UIKit


class ButtonViewController: UIViewController {
    
    @IBOutlet private weak var borderButton: SYButton!
    @IBOutlet private weak var border2Button: SYButton!
    @IBOutlet private weak var backgroundButton: SYButton!
    @IBOutlet private weak var textButton: SYButton!
    @IBOutlet private weak var rippleButton: SYButton!
    
    
    
    
    
    @IBOutlet weak var alphaBtn: SYButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "按钮 Button"
        
        borderButton.setTitle("Border Animation", for: .normal)
        borderButton.addTarget(self, action: #selector(borderAnimation(_:)), for: .touchUpInside)
        borderButton.startAnimating()

        
        border2Button.setTitle("BorderWithShadow Animation", for: .normal)
        border2Button.animationBorderColor = UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1)
        border2Button.addTarget(self, action: #selector(borderWithShadowAnimation(_:)), for: .touchUpInside)
        border2Button.animationType = .borderWithShadow
        border2Button.startAnimating()

        
        backgroundButton.setTitle("Background Animation", for: .normal)
        backgroundButton.addTarget(self, action: #selector(backgroundAnimation(_:)), for: .touchUpInside)
        backgroundButton.animationType = .background
        backgroundButton.startAnimating()

        
        textButton.setTitle("Text Animation", for: .normal)
        textButton.backgroundColor = UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1)
        textButton.animationTextColor = .white
        textButton.addTarget(self, action: #selector(textAnimation(_:)), for: .touchUpInside)
        textButton.animationType = .text
        textButton.startAnimating()

        
        rippleButton.setTitle("Ripple Animation", for: .normal)
        rippleButton.setTitleColor(UIColor.white, for: .normal)
        rippleButton.backgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
        rippleButton.addTarget(self, action: #selector(rippleAnimation(_:)), for: .touchUpInside)
        rippleButton.animationType = .ripple
        rippleButton
            .setFont(name: ".SFUIText-Medium", ofSize: 21)
            .startAnimating()
        rippleButton.startAnimating()

        
        doCustomAlpha()
    }
    
    
    
    func doCustomAlpha(){
        alphaBtn.setTitle("Alpha Animation", for: .normal)
        alphaBtn.addTarget(self, action: #selector(alphaAnimation(_:)), for: .touchUpInside)
        alphaBtn.startAnimating()
    }
    
    
    
    
    
    
    
    
    // MARK: - alpha Tap Events -
    
    
    
    @objc private func alphaAnimation(_ sender: SYButton) {
        if alphaBtn.isAnimating{
            print("stopAnimating")
            alphaBtn.stopAnimating()
        }
        else{
            print("startAnimating")
            alphaBtn.startAnimating()
        }
    }
    
    // MARK: - SYButton Tap Events -
    
    
    @objc private func borderAnimation(_ sender: SYButton) {
        if borderButton.isAnimating{
            print("stopAnimating")
            borderButton.stopAnimating()
        }
        else{
            print("startAnimating")
            borderButton.startAnimating()
        }
    }
    
    @objc private func borderWithShadowAnimation(_ sender: SYButton) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func backgroundAnimation(_ sender: SYButton) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func textAnimation(_ sender: SYButton) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func rippleAnimation(_ sender: SYButton) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
}
