//
//  InputViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 26/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class InputViewController: UIViewController {
    
    let bmiC = BMRCalculator()
    
    
    
    
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    //@IBOutlet weak var nextPage: UIButton!
    //@IBOutlet weak var warningTextLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
        
        startButton.layer.cornerRadius = 17.0
        startButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 17.0
        logoutButton.layer.masksToBounds = true
//        nextPage.layer.cornerRadius = 17.0
//        nextPage.layer.masksToBounds = true
        //warningTextLabel.isHidden = true
        
        
        
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
        SVProgressHUD.show()
        if ageTextField.text?.isEmpty ?? true || heightTextField.text?.isEmpty ?? true || weightTextField.text?.isEmpty ?? true {
            //warningTextLabel.isHidden = false
            let alert = UIAlertView(title: "Data Required", message: "Enter all required infomration", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            
        } else {
            
            let weight : Double = Double (weightTextField.text!)!
            let height : Double = Double(heightTextField.text!)!
            let age : Int = Int(ageTextField.text!)!
            let gender : String = genderTextField.text!
            
            bmiC.BmrFinal = bmiC.getBMR(weight: weight, height: height, age: age, gender: gender) //sending the data to BMR Calc class
            print(bmiC.BmrFinal)
            
           
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(ageTextField.text!)")
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(weightTextField.text!)")
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(heightTextField.text!)")
            
            ////// Uploading the data in Data Base
            let TDEE = Database.database().reference().child("TDEE") //sending messaged into new child database named Messages
            let messageDictionary = ["Sender" : Auth.auth().currentUser?.email , "TDEE" : String(bmiC.BmrFinal)]  // [sender,message]
         
            TDEE.childByAutoId().setValue(messageDictionary){//childautoid - create custom id for messages,this is automatic generated
                (error,reference) in
                if error != nil {
                    print(error!)
                    let alert = UIAlertView(title: "Connection Problem", message: "Try Agin", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    print ("Message saved successfully")
                   self.performSegue(withIdentifier: "goToHomeVC", sender: self)
                    SVProgressHUD.dismiss()

                }

            }
            
            
           
        }
        
    }
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeVC"{
            
            let destinationVC = segue.destination as! HomeViewController
           // destinationVC.delegate = self
            destinationVC.totalCalFromInputVC = bmiC.BmrFinal
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
