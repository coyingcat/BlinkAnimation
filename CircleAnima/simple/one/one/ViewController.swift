//
//  ViewController.swift
//  one
//
//  Created by Jz D on 2020/5/1.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func animate(_ sender: UIButton) {
        
        let diceRoll = CGFloat(Int(arc4random_uniform(7))*30)
        let circleEdge = CGFloat(200)

        // Create a new CircleView
        let circleView = CircleView(frame: CGRect(x: 50, y: diceRoll, width: circleEdge, height: circleEdge))

        view.addSubview(circleView)

        // Animate the drawing of the circle over the course of 1 second
        circleView.animateCircle(duration: 1.0)
        
        
    }
    
    

}

