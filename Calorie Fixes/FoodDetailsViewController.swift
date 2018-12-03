//
//  FoodDetailsViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 3/12/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Foundation

class FoodDetailsViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
 
    
    
    
    
    
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
   
    @IBAction func addAction(_ sender: Any) {
        
//        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//
//            self.emojiToPass = self.emojiOutlet.text
//            self.foodToPass = self.foodOutlet.text
//            self.servingsToPass = String(self.servingMultiplier)
//            self.servingSizeToPass = self.servingSizeRaw
//            self.baseCaloriesToPass = self.baseCalories
//            self.caloriesToPass = self.calorieOutlet.text
//
//            self.ndbnoToPass = self.ndbno
//
//            self.performSegue(withIdentifier: "toAddFood", sender: self)
//
        
    }
    
    var timer = Timer()
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        print("Updating")
        self.proteinOutlet.text = self.protein
        self.sugarOutlet.text = self.sugar
        self.fetOutlet.text = self.fat
        self.carbsOutlet.text = self.carbs
        self.cholestrolOutlet.text = self.cholestrol
        self.potassiumOutlet.text = self.potassium
        self.calorieOutlet.text = self.calories
        self.fiberOutlet.text = self.fiber
        self.sodiumOutlet.text = self.sodium
        self.servingSizeOutlet.text = self.servingLabel
    }
    
    
    

    
    


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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if component == 0 {
            return servingSize.count
        }
        else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0{
            return String(servingSize[row])
        }
        else{
            return "serving(s)"
        }
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        servingMultiplier = servingSize[row]
       // getNutrients(ndbno: ndbno)
        
    }
    

    
    var emojiToPass:String!
    var foodToPass:String!
    var servingsToPass:String!
    var servingSizeToPass: String!
    var baseCaloriesToPass:String!
    var caloriesToPass:String!
    var ndbnoToPass:String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toAddFood") {
            
            // initialize new view controller and cast it as your view controller
            //let viewController = segue.destination as! ConfirmFoodVC
            // your new view controller should have property that will store passed value
//            viewController.emoji = emojiToPass
//            viewController.food = foodToPass
//            viewController.servings = servingsToPass
//            viewController.servingSizeRaw = servingSizeToPass
//            viewController.baseCalories = baseCaloriesToPass
//            viewController.calories = caloriesToPass
//            viewController.ndbno = ndbnoToPass
//        }
    }

}
}
