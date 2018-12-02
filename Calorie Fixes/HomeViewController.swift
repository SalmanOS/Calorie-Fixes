//
//  HomeViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 26/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var totalCalFromInputVC = 0
    var remainingCal = 0
    
    let bmrC = BMRCalculator()
//    var totalCal :Int = 0
//    var remainingCal :Int = 0

    @IBOutlet weak var calorieGoal: UILabel!
    @IBOutlet weak var consumedCalories: UILabel!
    @IBOutlet weak var remainingCalories: UILabel!
   
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        retrieveMessages()
        calorieGoal.text = String (totalCalFromInputVC) //updated calorie goal from prepare segue
        remainingCalories.text = String ( totalCalFromInputVC - 100)
    }
    
    
    func retrieveMessages () {
        let TDEE = Database.database().reference().child("TDEE") //retrive messages
        
        TDEE.observe(.childAdded, with: { (snapshot) in //this closer will get called when new child added ie new message saved in DB,and it returns snapshot
            let snapshotValue = snapshot.value as! Dictionary<String,String> // treat this data as dictionary
            
            let text = snapshotValue["TDEE"]! //TDEE From the FIREBASE
            let sender = snapshotValue ["Sender"]!
            
            self.userName.text = "Welcome , "+sender
            

            
 
            
        })
    }
//    func getCal (totalCal : Int , remainingCal : Int){
//        print(totalCal)
//        print(remainingCal)
//    }
    

   

}
