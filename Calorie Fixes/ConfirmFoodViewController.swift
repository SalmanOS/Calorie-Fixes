//
//  ConfirmFoodViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 10/12/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ConfirmFoodViewController: UIViewController {
    
    var emoji: String!
    var food: String!
    var servings: String!
    var servingSizeRaw: String!
    var baseCalories: String!
    var calories: String!
    var ndbno: String!
    
    var meals: Array = ["Breakfast", "Lunch", "Dinner", "Snack"]
    var servingSize = Array(1...50)
    var servingMultiplier: Int! = 1
    
    var servingLabel: String!
    
    var timer = Timer()
    
    var newCalories: String!
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        print("Updating")
        self.caloriesOutlet.text = self.newCalories
    }
    
    
    
    
//    @IBOutlet weak var emojiLabel: UILabel!
//    @IBOutlet weak var foodLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var datePicker: UIDatePicker!
//    @IBOutlet weak var mealOutlet: UILabel!
//    @IBOutlet weak var mealPicker: UIPickerView!
//    @IBOutlet weak var servingsLabel: UILabel!
//    @IBOutlet weak var servingsPicker: UIPickerView!
//    @IBOutlet weak var caloriesOutlet: UILabel!
    
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var mealOutLet: UILabel!
    @IBOutlet weak var mealPicker: UIPickerView!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var servingsPicker: UIPickerView!
    @IBOutlet weak var caloriesOutlet: UILabel!
  
    
    @IBAction func savePressed(_ sender: Any) {
        
        if mealOutLet.text != ""{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let task = Foods(context: context)
            
            
            task.name = food
            
            
            
            
            task.meal = mealOutLet.text
            task.servings = String(servingMultiplier)
            task.calories = caloriesOutlet.text
            task.servingSize = servingSizeRaw
            task.ndbno = ndbno
            
            //Save the data to CoreData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            print("CoreData has been saved to")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "InitialView") as! UITabBarController
            vc.selectedIndex = 2
            present(vc, animated: true, completion: nil)
            
        }
        else{
            
            let alert = UIAlertController(title: "Invalid Meal", message: "Please enter a valid meal.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Confirm Food View Loaded")
        
        mealPicker.delegate = (self as! UIPickerViewDelegate)
        servingsPicker.delegate = (self as! UIPickerViewDelegate)
        
        
        //Load label values
       // emojiLabel.text = emoji
        foodLabel.text = food
        servingsLabel.text = servings
        caloriesOutlet.text = calories
        
       // dateLabelSetup()
        
        print(emoji)
        print(food)
        print(servings)
        print(servingSizeRaw)
        print(baseCalories)
        print(calories)
        print(ndbno)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show the navigation bar on other view controllers
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
 
    
    
   
    func toggleMealpicker() {
        
        mealPickerHidden = !mealPickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    func toggleServingspicker() {
        
        servingsPickerHidden = !servingsPickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 && indexPath.row == 1 {
//            toggleDatepicker()
//        }
         if indexPath.section == 0 && indexPath.row == 3 {
            toggleMealpicker()
        }
        else if indexPath.section == 0 && indexPath.row == 5 {
            toggleServingspicker()
        }
    }
    
    //var datePickerHidden = true
    var mealPickerHidden = true
    var servingsPickerHidden = true
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if datePickerHidden && indexPath.section == 0 && indexPath.row == 2 {
//            return 0
//        }
        if mealPickerHidden && indexPath.section == 0 && indexPath.row == 4 {
            return 0
        }
        else if servingsPickerHidden && indexPath.section == 0 && indexPath.row == 6 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    //Picker View Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == mealPicker {
            return meals.count
        }
        else if pickerView == servingsPicker{
            return servingSize.count
        }
        else{
            return 1
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == mealPicker{
            return meals[row]
        }
        else {
            //else if pickerView == activityPicker{
            return String(servingSize[row])
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == mealPicker {
            mealOutLet.text = meals[row]
            
        }
        else if pickerView == servingsPicker {
            
            
            if timer.isValid{
                
            }
            else{
                scheduledTimerWithTimeInterval()
            }
            
            
            servingsLabel.text = " \(String(servingSize[row])) serving(s)"
            
            servingMultiplier = servingSize[row]
            
            calculateCalories()
            
        }
    }
    
    func calculateCalories(){
        let calculatedDouble: Double =  Double(self.baseCalories)!
        
        let calculated = calculatedDouble * Double(self.servingMultiplier)
        
        let calculatedInt = Int(calculated)
        
        let subtitleString = "\(calculatedInt)"
        
        self.newCalories = subtitleString
        
    }
}
