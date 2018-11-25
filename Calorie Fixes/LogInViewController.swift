//
//  LogInViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 25/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        logInButton.layer.cornerRadius = 17.0
        logInButton.layer.masksToBounds = true
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var logInButton: UIButton!
    @IBAction func logInPressed(_ sender: Any) {
      
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
