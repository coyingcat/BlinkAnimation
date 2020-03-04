//
//  ButtonViewController.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 2015/12/13.
//  Copyright © 2015年 CocoaPods. All rights reserved.
//

import UIKit


class ButtonViewController: UIViewController {
    
    @IBOutlet private weak var borderButton: BlinkLayoutBtn!
    @IBOutlet private weak var border2Button: BlinkLayoutBtn!
    
    
    @IBOutlet private weak var backgroundButton: BlinkLayoutBtn!
    
    
    
    @IBOutlet private weak var textButton: BlinkBtn!
    @IBOutlet private weak var rippleButton: BlinkBtn!
    
    
    
    
    
    @IBOutlet weak var alphaBtn: BlinkLayoutBtn!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "按钮 Button"
        

        borderButton.animationType = .border
        borderButton.addTarget(self, action: #selector(borderAnimation(_:)), for: .touchUpInside)
        borderButton.startAnimating()

        
        
        border2Button.animationBorderColor = UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1)
        border2Button.addTarget(self, action: #selector(borderWithShadowAnimation(_:)), for: .touchUpInside)
        border2Button.animationType = .borderWithShadow
        border2Button.startAnimating()

        
        
        
        
        backgroundButton.addTarget(self, action: #selector(backgroundAnimation(_:)), for: .touchUpInside)
        backgroundButton.animationType = .background
        backgroundButton.startAnimating()

        
        textButton.setTitle("Text Animation", for: .normal)
        textButton.backgroundColor = UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1)
        textButton.animationTextColor = .white
        textButton.addTarget(self, action: #selector(textAnimation(_:)), for: .touchUpInside)
        textButton.animationType = .text
        textButton.startAnimating()

        
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
        alphaBtn.animationType = .opaque
        alphaBtn.addTarget(self, action: #selector(alphaAnimation(_:)), for: .touchUpInside)
        alphaBtn.startAnimating()
    }
    
    
    
    
    
    
    
    
    // MARK: - alpha Tap Events -
    
    
    
    @objc
    private func alphaAnimation(_ sender: BlinkLayoutBtn) {
        if alphaBtn.isAnimating{
            print("stopAnimating")
            alphaBtn.stopAnimating()
        }
        else{
            print("startAnimating")
            alphaBtn.startAnimating()
        }
    }
    
    // MARK: - BlinkLayoutBtn Tap Events -
    
    
    @objc private func borderAnimation(_ sender: BlinkLayoutBtn) {
        if borderButton.isAnimating{
            print("stopAnimating")
            borderButton.stopAnimating()
        }
        else{
            print("startAnimating")
            borderButton.startAnimating()
        }
    }
    
    @objc private func borderWithShadowAnimation(_ sender: BlinkLayoutBtn) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func backgroundAnimation(_ sender: BlinkLayoutBtn) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func textAnimation(_ sender: BlinkLayoutBtn) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
    
    @objc private func rippleAnimation(_ sender: BlinkLayoutBtn) {
        sender.isAnimating ? sender.stopAnimating() : sender.startAnimating()
    }
}
