//
//  ViewController.swift
//  power
//
//  Created by Jz D on 2020/5/1.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressRing = UICircularRing(frame: CGRect(x: 100, y: 100, width: 250, height: 250))
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(progressRing)
    }

    @IBAction func animate(_ sender: UIButton) {
        
        progressRing.startAnimation()
        
    }
    

}

