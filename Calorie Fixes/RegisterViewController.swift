//
//  RegisterViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 25/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        registerButton.layer.cornerRadius = 15.0
        registerButton.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
         SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (
            user, error) in
            if error != nil
            {
                print(error!)
                SVProgressHUD.dismiss()
            }
            else{
                print ("/////////////Registration Successful!//////////")
                SVProgressHUD.dismiss()
            }
        }
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
