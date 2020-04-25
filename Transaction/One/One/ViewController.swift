//
//  ViewController.swift
//  One
//
//  Created by Jz D on 2020/4/25.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var styledButton = { () -> UIButton in
        let edge: CGFloat = 125
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: edge, height: edge))
        btn.layer.cornerRadius = edge/2
        btn.backgroundColor = UIColor(red: 57/255.0, green: 73/255.0, blue: 171/255.0, alpha: 1)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        styledButton.center = view.center
        view.addSubview(styledButton)
    }
    

    @IBAction func start(_ sender: UIButton) {
        // Call animation
        animateButton()
    }
    
    fileprivate func animateButton(duration: CFTimeInterval = 1.0) {
       let oldValue = styledButton.frame.width/2
       let newButtonWidth: CGFloat = styledButton.frame.width/5
       
       let timingFunction = CAMediaTimingFunction(controlPoints: 0.65, -0.55, 0.27, 1.55)
       
       /* Do Animations */
       CATransaction.begin()
       CATransaction.setAnimationDuration(duration)
       CATransaction.setAnimationTimingFunction(timingFunction)

       // View animations
       UIView.animate(withDuration: duration) {
           self.styledButton.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
           self.styledButton.center = self.view.center
       }
       
       // Layer animations
       let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
       cornerAnimation.fromValue = oldValue
       cornerAnimation.toValue = newButtonWidth/2
       
       styledButton.layer.cornerRadius = newButtonWidth/2
       styledButton.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
       
       CATransaction.commit()
    }
}
