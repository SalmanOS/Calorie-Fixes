//
//  ViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 25/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let screenSize: CGSize = UIScreen.main.bounds.size
        print (screenSize)
        logInButton.layer.cornerRadius = 17.0
        logInButton.layer.masksToBounds = true
        
        registerButton.layer.cornerRadius = 17.0
        registerButton.layer.masksToBounds = true
        
    }


}

