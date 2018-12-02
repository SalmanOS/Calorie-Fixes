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

    
   //*******************************
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    //******************************
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.backgroundColor = UIColor.lightGray
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
    
    
  


}
