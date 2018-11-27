//
//  LogInViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 25/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LogInViewController: UIViewController {
    

    
    
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        logInButton.layer.cornerRadius = 17.0
        logInButton.layer.masksToBounds = true
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var logInButton: UIButton!
    @IBAction func logInPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error != nil
            {
                let alert = UIAlertView(title: "Incorrect Password or Username", message: "Enter correct password/username", delegate: self, cancelButtonTitle: "OK")
                alert.show()
               
                print (error!)
                SVProgressHUD.dismiss()
                //self.wrongTextLabel.isHidden = true
            }
            else{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToMainPage", sender: self)
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
