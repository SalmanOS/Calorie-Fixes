//
//  BMI Calculator.swift
//
//
//  Created by SalmanOS on 27/11/18.


import Foundation

class BMRCalculator {

  
    var BmrFinal : Int = 0;
    
    func getBMR(weight : Double, height : Double , age : Int , gender : String)->Int{
        //Declare local variables
        
   
        
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
    

}
