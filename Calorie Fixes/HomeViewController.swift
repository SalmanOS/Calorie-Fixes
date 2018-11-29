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
    
    let bmrC = BMRCalculator()

    @IBOutlet weak var calorieGoal: UILabel!
    @IBOutlet weak var consumedCalories: UILabel!
    @IBOutlet weak var remainingCalories: UILabel!
   
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print (bmrC.BmrFinal)
//        calorieGoal.text = "\(bmrC.BmrFinal)"
       // consumedCalories.text = String (35)
        retrieveMessages()

        // Do any additional setup after loading the view.
    }
    
    func retrieveMessages () {
        let TDEE = Database.database().reference().child("TDEE") //retrive messages
        
        TDEE.observe(.childAdded, with: { (snapshot) in //this closer will get called when new child added ie new message saved in DB,and it returns snapshot
            let snapshotValue = snapshot.value as! Dictionary<String,String> // treat this data as dictionary
            
            let text = snapshotValue["TDEE"]!
            let sender = snapshotValue ["Sender"]!
            
            self.calorieGoal.text = text
            self.userName.text = "Welcome , "+sender
            self.consumedCalories.text = "0"
            self.remainingCalories.text = snapshotValue["TDEE"]
            
 //           let message = Message()  //message object created
//            message.messageBody = text
//            message.sender = sender
//
//            self.messageArray.append(message) //saving the messages in messageArray, so we can pull them out
//            self.configureTable()
//            self.messageTableView.reloadData() //reload
            
        })
    }
    

   

}
