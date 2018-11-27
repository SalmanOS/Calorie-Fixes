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
    
    let bmiC = BMRCalculator()
    
    
    
    
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    //@IBOutlet weak var warningTextLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
        
        startButton.layer.cornerRadius = 17.0
        startButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 17.0
        logoutButton.layer.masksToBounds = true
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
        if ageTextField.text?.isEmpty ?? true || heightTextField.text?.isEmpty ?? true || weightTextField.text?.isEmpty ?? true {
            //warningTextLabel.isHidden = false
            let alert = UIAlertView(title: "Data Required", message: "Enter all required infomration", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
            
        } else {
            performSegue(withIdentifier: "goToHomeVC", sender: self)
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(ageTextField.text!)")
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(weightTextField.text!)")
            print("\\\\\\\\\\\\\\\\\\\\\\\\\\ \(heightTextField.text!)")
            
            
            print (getBMR())
            bmiC.Bmr = getBMR()
        }
        
    }
    
   
    
    func getBMR()->Int{
        //Declare local variables
        
        let weight : Double = Double (weightTextField.text!)!
        let height : Double = Double(heightTextField.text!)!
        let age : Int = Int(ageTextField.text!)!
        let gender : String = genderTextField.text!
        
        var BMR = 0.0
        var weightCalculation = 0.0
        var heightCalculation = 0.0
        var ageCalculaition = 0.0
        
        //If Gender is Male, use the following formula: BMR=66.47+ (13.75 x W) + (5.0 x H) - (6.75 x A)
        if (gender == "male") || (gender == "Male") || (gender == "MALE") {
            weightCalculation = 10 * weight
            heightCalculation = 6.25 * height
            ageCalculaition = 5 * Double(age)
            
            BMR = 5 + weightCalculation + heightCalculation - ageCalculaition
            
            return Int(BMR * 1.3)
        }
            //Else Gender is Female, use the following formula: BMR=665.09 + (9.56 x W) + (1.84 x H) - (4.67 x A)
        else{
            weightCalculation = 10 * weight
            heightCalculation = 6.25 * height
            ageCalculaition = 5 * Double(age)
            
            BMR = weightCalculation + heightCalculation - ageCalculaition - 161
            
            return Int(BMR * 1.3)
        }
    }
    
    //Formula to calculate remaining calories
    func getRemaining(goal: Int, current: Int)->Int{
        var remaining = goal - current
        if remaining < 0 {
            remaining = 0
        }
        return remaining
    }
    
    // Function to convert from pounds to killograms
    private func toKilograms(weight:Double)->Double{
        return weight/2.2
    }
    
    // Function to convert from inches into centemiters
    private func toCentimeters(height:Double)->Double{
        return height*2.54
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
