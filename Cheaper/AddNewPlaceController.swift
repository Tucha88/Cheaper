//
//  AddNewPlaceController.swift
//  Cheaper
//
//  Created by Admin on 20/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class AddNewPlaceController: UITableViewController {
    
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    @IBOutlet weak var CoffeeSwitch: UISwitch!
    @IBOutlet weak var KosherSwitch: UISwitch!
    @IBOutlet weak var DiscountSwitch: UISwitch!
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeFeedback: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    
}
