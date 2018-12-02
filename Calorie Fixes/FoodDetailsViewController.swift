//
//  FoodDetailsViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 3/12/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Foundation

class FoodDetailsViewController: UIViewController , UIPickerViewDelegate {
    
    
    
    
    
    var food: String!
    var ndbno: String!
    var emoji: String!
    var caloriesPassed: String!
    
    var servingSize = Array(1...50)
    var servingMultiplier: Int! = 1
    
    var servingLabel: String!
    
    var window: UIWindow?
    var tabDestination: Int! = 2
    
    //Serving Size
    
    //Protein NutrientID 203
    var protein: String!
    //Sugar NutrientID 269
    var sugar: String!
    //Fat NutrientID 204
    var fat: String!
    //Carbs NutrientID 205
    var carbs: String!
    //Cholesterol NutrientID 601
    var cholestrol: String!
    //Potassium NutrientID 306
    var potassium: String!
    //Energy NutrientID 208
    var calories: String!
    //Fiber NutrientID 291
    var fiber: String!
    //Sodium NutrientID 307
    var sodium: String!
    
    var baseCalories: String!
    var servingSizeRaw: String!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emojiOutlet: UILabel!
    @IBOutlet weak var foodOutlet: UILabel!
    @IBOutlet weak var calorieOutlet: UILabel!
    @IBOutlet weak var servingPickerOutlet: UIPickerView!
    @IBOutlet weak var fetOutlet: UILabel!
    @IBOutlet weak var cholestrolOutlet: UILabel!
    @IBOutlet weak var sodiumOutlet: UILabel!
    @IBOutlet weak var carbsOutlet: UILabel!
    @IBOutlet weak var proteinOutlet: UILabel!
    @IBOutlet weak var sugarOutlet: UILabel!
    @IBOutlet weak var potassiumOutlet: UILabel!
    @IBOutlet weak var fiberOutlet: UILabel!
    @IBOutlet weak var servingSizeOutlet: UILabel!
    
    

    
    
    
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var emojiOutlet: UILabel!
//    @IBOutlet weak var foodOutlet: UILabel!
//    @IBOutlet weak var calorieOutlet: UILabel!
//    @IBOutlet weak var servingPickerOutlet: UIPickerView!
//    @IBOutlet weak var fatOutlet: UILabel!
//    @IBOutlet weak var cholesterolOutlet: UILabel!
//    @IBOutlet weak var sodiumOutlet: UILabel!
//    @IBOutlet weak var carbsOutlet: UILabel!
//    @IBOutlet weak var proteinOutlet: UILabel!
//    @IBOutlet weak var sugarOutlet: UILabel!
//    @IBOutlet weak var potassiumOutlet: UILabel!
//    @IBOutlet weak var fiberOutlet: UILabel!
//    @IBOutlet weak var servingSizeOutlet: UILabel!

//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        <#code#>
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        <#code#>
//    }
//
//


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
