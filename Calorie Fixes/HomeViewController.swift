//
//  HomeViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 26/11/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let bmrC = BMRCalculator()

    @IBOutlet weak var calorieGoal: UILabel!
    @IBOutlet weak var consumedCalories: UILabel!
    @IBOutlet weak var remainingCalories: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (bmrC.BmrFinal)
        calorieGoal.text = "\(bmrC.BmrFinal)"
        consumedCalories.text = String (35)

        // Do any additional setup after loading the view.
    }
    

   

}
