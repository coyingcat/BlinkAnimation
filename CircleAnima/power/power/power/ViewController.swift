//
//  ViewController.swift
//  power
//
//  Created by Jz D on 2020/5/1.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressRing = { () -> UICircularProgressRing in
        let ring = UICircularProgressRing(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
        ring.maxValue = 50
        ring.style = .inside
        
        // Change any of the properties you'd like
        return ring
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(progressRing)
    }

    @IBAction func animate(_ sender: UIButton) {
        
        progressRing.startProgress(to: 30, duration: 2.0) {
          print("Done animating!")
          // Do anything your heart desires...
        }
        
    }
    

}

