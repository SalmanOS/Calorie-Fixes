//
//  InputViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 26/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Firebase

class InputViewController: UIViewController {
    
    
    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var goalPicker: UISegmentedControl!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
        
        startButton.layer.cornerRadius = 17.0
        startButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 17.0
        logoutButton.layer.masksToBounds = true
        
    }
    
    @IBAction func genderPicked(_ sender: Any) {
    }
    @IBAction func goalPicked(_ sender: Any) {
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("Error there was problem signing out")
        }
    }
    
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
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
