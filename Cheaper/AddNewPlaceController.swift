//
//  AddNewPlaceController.swift
//  Cheaper
//
//  Created by Admin on 20/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class AddNewPlaceController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    @IBOutlet weak var CoffeeSwitch: UISwitch!
    @IBOutlet weak var KosherSwitch: UISwitch!
    @IBOutlet weak var DiscountSwitch: UISwitch!
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeFeedback: UIButton!
    
    var newPlace = NewPlace()
    var images:[UIImage]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //delegates
        placeName.delegate = self
    }
    
    @IBAction func submitNewPlace(_ sender: UIButton) {
    }
    
    
    
    // keyboard "done" button to hide it
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
