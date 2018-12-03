//
//  SearchFoodViewController.swift
//  Calorie Fixes
//
//  Created by SalmanOS on 2/12/18.
//  Copyright © 2018 SalmanOS. All rights reserved.
//

import UIKit
import Foundation


class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    
   
    
}


class SearchFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    
    var nameArray: Array<String> = []
    var ndbnoArray: Array<String> = []
    var descriptionArray: Array<String> = []
    
    var foodDone: Bool = false
    var caloriesDone: Bool = false
    
    
    var timer = Timer()
    
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        
        //getResults()
        
        if (self.descriptionArray.count == self.nameArray.count){
            //print("Reloading TableView")
            
            self.tableView.reloadData()
        }
    }

    

    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.backgroundColor = UIColor.lightGray
        tableView.delegate=self
        tableView.dataSource=self
        self.activityIndicatorView = activityIndicatorView
        searchBar.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getResults() {
        
        
        activityIndicatorView.startAnimating()
        
        let apiKey: String = "C4eNyMBMhGhR2ju0J6pTEMfnusDLQR5uCmKXY7B9"
        let searchString: String = searchBar.text!
        let escapedSearch: String = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) as String!
        let numResults = 30
        
        //let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        //DispatchQueue.main.asyncAfter(deadline: when) {
        DispatchQueue.main.async {
            let jsonUrlString = "https://api.nal.usda.gov/ndb/search/?format=json&q=\(escapedSearch)&sort=r&max=\(numResults)&offset=0&api_key=\(apiKey)"
            guard let url = URL(string: jsonUrlString) else { return }
            
            self.nameArray.removeAll()
            self.ndbnoArray.removeAll()
            self.descriptionArray.removeAll()
            
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                guard let data = data else {
                    return
                }
                
                let dataAsString = String(data: data, encoding: .utf8)
                
                do {
                    
                    let data = dataAsString?.data(using: .utf8)!
                    if let json = try? JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                        
                        
                        if let list = json?["list"] as? [String:Any] {
                            if let itemArray = list["item"] as? NSArray {
                                for item in itemArray {
                                    if let itemDict = item as? NSDictionary {
                                        if let name = itemDict.value(forKey: "name"){
                                            
                                            let nameString = name as! String
                                            let token = nameString.components(separatedBy: ", UPC:")
                                            let tokenTwo = token[0].components(separatedBy: ", GTIN:")
                                            
                                            self.nameArray.append(tokenTwo[0])
                                        }
                                        if let ndbno = itemDict.value(forKey: "ndbno"){
                                            
                                            self.ndbnoArray.append(ndbno as! String)
                                            self.getCalories(ndbno: ndbno as! String)
                                            print("Calculating Calories")
                                            
                                        }
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                }.resume()
        }
        
        foodDone = true
        
        
    }
    
    func getCalories(ndbno: String){
        
        //-----------------------------------------------------------------------------
        //Get Calories
        //-----------------------------------------------------------------------------
        let when = DispatchTime.now() + 0.25 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            //DispatchQueue.main.async {
            let apiKey: String = "C4eNyMBMhGhR2ju0J6pTEMfnusDLQR5uCmKXY7B9"
            let jsonUrlString = "https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=\(apiKey)&nutrients=208&ndbno=\(ndbno)"
            let url = URL(string: jsonUrlString)
            
            print("Getting calories")
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                
                guard let data = data else {
                    return
                }
                
                let dataAsString = String(data: data, encoding: .utf8)
                
                do {
                    
                    let data = dataAsString?.data(using: .utf8)!
                    if let json = try? JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                        
                        print("Debug Statement")
                        
                        if let report = json!["report"] as? [String:Any]{
                            
                            if let foods = report["foods"] as? NSArray{
                                if let nutrients = foods[0] as? [String:Any]{
                                    let measureSize: String = (nutrients["measure"]) as! String
                                    if let nextNutrients = nutrients["nutrients"] as? NSArray {
                                        if let info = nextNutrients[0] as? [String:Any] {
                                            let value: String = info["value"] as! String
                                            
                                            let subtitleString = "\(value) calories / \(measureSize)"
                                            
                                            print(subtitleString)
                                            
                                            self.descriptionArray.append(subtitleString)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    print(self.descriptionArray.count)
                    print(self.nameArray.count)
                    
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                
                }.resume()
            
            
            
            
            
            
            
        }
        
        //-----------------------------------------------------------------------------
        //-----------------------------------------------------------------------------
        
        caloriesDone = true
        
        
        
    }
    
    func getEmoji(title: String) -> String{
        
        if title.localizedCaseInsensitiveContains("apple"){
            return "🍎"
        }
        else if title.localizedCaseInsensitiveContains("pear"){
            return "🍐"
        }
        else if title.localizedCaseInsensitiveContains("orange"){
            return "🍊"
        }
        else if title.localizedCaseInsensitiveContains("tangerine"){
            return "🍊"
        }
        else if title.localizedCaseInsensitiveContains("banana"){
            return "🍌"
        }
        else if title.localizedCaseInsensitiveContains("watermelon"){
            return "🍉"
        }
        else if title.localizedCaseInsensitiveContains("grape"){
            return "🍇"
        }
        else if title.localizedCaseInsensitiveContains("strawberry"){
            return "🍓"
        }
        else if title.localizedCaseInsensitiveContains("melon"){
            return "🍈"
        }
        else if title.localizedCaseInsensitiveContains("cherry"){
            return "🍒"
        }
        else if title.localizedCaseInsensitiveContains("cherries"){
            return "🍒"
        }
        else if title.localizedCaseInsensitiveContains("peach"){
            return "🍑"
        }
        else if title.localizedCaseInsensitiveContains("pineapple"){
            return "🍍"
        }
        else if title.localizedCaseInsensitiveContains("kiwi"){
            return "🥝"
        }
        else if title.localizedCaseInsensitiveContains("avocado"){
            return "🥑"
        }
        else if title.localizedCaseInsensitiveContains("tomato"){
            return "🍅"
        }
        else if title.localizedCaseInsensitiveContains("eggplant"){
            return "🍆"
        }
        else if title.localizedCaseInsensitiveContains("cucumber"){
            return "🥒"
        }
        else if title.localizedCaseInsensitiveContains("carrot"){
            return "🥕"
        }
        else if title.localizedCaseInsensitiveContains("peanut"){
            return "🥜"
        }
        else if title.localizedCaseInsensitiveContains("honey"){
            return "🍯"
        }
        else if title.localizedCaseInsensitiveContains("croissant"){
            return "🥐"
        }
        else if title.localizedCaseInsensitiveContains("bread"){
            return "🍞"
        }
        else if title.localizedCaseInsensitiveContains("baguette"){
            return "🥖"
        }
        else if title.localizedCaseInsensitiveContains("egg"){
            return "🥚"
        }
        else if title.localizedCaseInsensitiveContains("bacon"){
            return "🥓"
        }
        else if title.localizedCaseInsensitiveContains("pancake"){
            return "🥞"
        }
        else if title.localizedCaseInsensitiveContains("shrimp"){
            return "🍤"
        }
        else if title.localizedCaseInsensitiveContains("leg"){
            return "🍗"
        }
        else if title.localizedCaseInsensitiveContains("bone"){
            return "🍖"
        }
        else if title.localizedCaseInsensitiveContains("pizza"){
            return "🍕"
        }
        else if title.localizedCaseInsensitiveContains("pepper"){
            return "🌶"
        }
        else if title.localizedCaseInsensitiveContains("dog"){
            return "🌭"
        }
        else if title.localizedCaseInsensitiveContains("burger"){
            return "🍔"
        }
        else if title.localizedCaseInsensitiveContains("mac"){
            return "🍔"
        }
        else if title.localizedCaseInsensitiveContains("nugget"){
            return "🐔"
        }
        else if title.localizedCaseInsensitiveContains("fries"){
            return "🍟"
        }
        else if title.localizedCaseInsensitiveContains("fry"){
            return "🍟"
        }
        else if title.localizedCaseInsensitiveContains("potato"){
            return "🥔"
        }
        else if title.localizedCaseInsensitiveContains("sandwich"){
            return "🥙"
        }
        else if title.localizedCaseInsensitiveContains("burrito"){
            return "🌯"
        }
        else if title.localizedCaseInsensitiveContains("taco"){
            return "🌮"
        }
        else if title.localizedCaseInsensitiveContains("salad"){
            return "🥗"
        }
        else if title.localizedCaseInsensitiveContains("dress"){
            return "🥗"
        }
        else if title.localizedCaseInsensitiveContains("spaghetti"){
            return "🍝"
        }
        else if title.localizedCaseInsensitiveContains("pasta"){
            return "🍜"
            
        }else if title.localizedCaseInsensitiveContains("sushi"){
            return "🍣"
        }
        else if title.localizedCaseInsensitiveContains("curry"){
            return "🍛"
        }
        else if title.localizedCaseInsensitiveContains("rice"){
            return "🍚"
        }
        else if title.localizedCaseInsensitiveContains("rice ball"){
            return "🍙"
        }
        else if title.localizedCaseInsensitiveContains("ice"){
            return "🍧"
        }
        else if title.localizedCaseInsensitiveContains("ice cream"){
            return "🍦"
        }
        else if title.localizedCaseInsensitiveContains("cream"){
            return "🍦"
        }
        else if title.localizedCaseInsensitiveContains("cake"){
            return "🍰"
        }
        else if title.localizedCaseInsensitiveContains("lemon"){
            return "🍋"
        }
        else if title.localizedCaseInsensitiveContains("lollipop"){
            return "🍭"
        }
        else if title.localizedCaseInsensitiveContains("popcorn"){
            return "🍿"
        }
        else if title.localizedCaseInsensitiveContains("corn"){
            return "🌽"
        }
        else if title.localizedCaseInsensitiveContains("donut"){
            return "🍩"
        }
        else if title.localizedCaseInsensitiveContains("chocolate"){
            return "🍫"
        }
        else if title.localizedCaseInsensitiveContains("candy"){
            return "🍬"
        }
        else if title.localizedCaseInsensitiveContains("cookie"){
            return "🍪"
        }
        else if title.localizedCaseInsensitiveContains("milk"){
            return "🥛"
        }
        else if title.localizedCaseInsensitiveContains("coffee"){
            return "☕️"
        }
        else if title.localizedCaseInsensitiveContains("tea"){
            return "🍵"
        }
        else if title.localizedCaseInsensitiveContains("beer"){
            return "🍺"
        }
        else if title.localizedCaseInsensitiveContains("wine"){
            return "🍷"
        }
        else if title.localizedCaseInsensitiveContains("liquor"){
            return "🥃"
        }
        else if title.localizedCaseInsensitiveContains("cocktail"){
            return "🍸"
        }
        else if title.localizedCaseInsensitiveContains("drink"){
            return "🍹"
        }
        else if title.localizedCaseInsensitiveContains("cheese"){
            return "🧀"
        }
        else if title.localizedCaseInsensitiveContains("fish"){
            return "🐟"
        }
        else if title.localizedCaseInsensitiveContains("crab"){
            return "🦀"
        }
        else if title.localizedCaseInsensitiveContains("mushroom"){
            return "🍄"
        }
        else if title.localizedCaseInsensitiveContains("turkey"){
            return "🦃"
        }
        else if title.localizedCaseInsensitiveContains("chicken"){
            return "🐔"
        }
        else if title.localizedCaseInsensitiveContains("pork"){
            return "🐖"
        }
        else if title.localizedCaseInsensitiveContains("beef"){
            return "🐄"
        }
        else if title.localizedCaseInsensitiveContains("steak"){
            return "🐄"
        }
        else if title.localizedCaseInsensitiveContains("venison"){
            return "🦌"
        }
        else if title.localizedCaseInsensitiveContains("mutton"){
            return "🐑"
        }
        else if title.localizedCaseInsensitiveContains("lamb"){
            return "🐑"
        }
        else if title.localizedCaseInsensitiveContains("squid"){
            return "🦑"
        }
        else if title.localizedCaseInsensitiveContains("duck"){
            return "🦆"
        }
        else if title.localizedCaseInsensitiveContains("bird"){
            return "🐦"
        }
        else if title.localizedCaseInsensitiveContains("cod"){
            return "🐟"
        }
        else if title.localizedCaseInsensitiveContains("salmon"){
            return "🐟"
        }
        else if title.localizedCaseInsensitiveContains("flounder"){
            return "🐟"
        }
        else if title.localizedCaseInsensitiveContains("tilapia"){
            return "🐟"
        }
        else if title.localizedCaseInsensitiveContains("icing"){
            return "🍰"
        }
        else if title.localizedCaseInsensitiveContains("sugar"){
            return "🍬"
        }
        else{
            return "🍽"
        }
        
        
        
    }
    
    
    //*******************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Placeholder
        if nameArray.count > 0 && descriptionArray.count > 0 && ndbnoArray.count > 0{
            return nameArray.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        //Placeholder
        if nameArray.count > 0 && ndbnoArray.count > 0{
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell1", for: indexPath) as! FoodTableViewCell
            
            //HAVE TO OPEN A CUSTOM CELL FOR IT. CHECK FLASH CHAT APP. CHECK NEXT MORNING
            
            if (nameArray.count == descriptionArray.count){
                
                let name = nameArray[indexPath.row]
                
                cell.titleOutlet.text = name
                
                let description = descriptionArray[indexPath.row]

                
                cell.descriptionOutlet.text = description
                
                let emoji = getEmoji(title: name)
                
                cell.emojiOutlet.text = emoji
                
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
                
            }
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell1", for: indexPath)
            return cell
            
        }
    }
    
    //******************************
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        if timer.isValid{
            
        }
        else{
            scheduledTimerWithTimeInterval()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        
        if searchBar.text! == "" {
            self.nameArray.removeAll()
            self.ndbnoArray.removeAll()
            self.descriptionArray.removeAll()
            foodDone = false
            caloriesDone = false
            self.tableView.reloadData()
        } else {
            // Filter the results
            self.nameArray.removeAll()
            self.ndbnoArray.removeAll()
            self.descriptionArray.removeAll()
            foodDone = false
            caloriesDone = false
            self.tableView.reloadData()
            getResults()
            
            view.endEditing(true)
        }
    }
    
    var foodToPass:String!
    var ndbnoToPass:String!
    var emojiToPass:String!
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let currentCell = tableView.cellForRow(at: indexPath) as! FoodTableViewCell
        
        //Get Weight and Date from label to pass into details screen
        foodToPass = currentCell.titleOutlet.text
        ndbnoToPass = ndbnoArray[indexPath.row]
        emojiToPass = currentCell.emojiOutlet.text
        
        self.performSegue(withIdentifier: "FoodDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "FoodDetails") { //passing the value to FoodDetailsViewController
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! FoodDetailsViewController
            // your new view controller should have property that will store passed value
            viewController.food = foodToPass
            viewController.ndbno = ndbnoToPass
            viewController.emoji = emojiToPass
        }
    }
    
    
    
  
    
    
    

}
