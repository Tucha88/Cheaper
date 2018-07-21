//
//  HistoryTableViewController.swift
//  Cheaper
//
//  Created by 11111 on 20/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit



class HistoryTableViewController: UITableViewController {
    
    var historyCheaperPlaces = [CheaperPalce]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let place : CheaperPalce = CheaperPalce(id: "11111", name: "name", lat: 32, lng: 32, description: "descriptiontest", googleId: "test", tags: ["test1","test2"], likes: 1, dislikes: 1)
        historyCheaperPlaces.append(place)
        historyCheaperPlaces.append(place)
        historyCheaperPlaces.append(place)
        historyCheaperPlaces.append(place)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyCheaperPlaces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("HistoryTableViewCell", owner: self, options: nil)?.first as! HistoryTableViewCell
        cell.PlaceHistoryNameText.text = historyCheaperPlaces[indexPath.row].name
        cell.PlaceHistoryImageDesctiption.text = historyCheaperPlaces[indexPath.row].description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 135
    }
    
}
