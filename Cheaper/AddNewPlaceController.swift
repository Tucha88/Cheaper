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
    @IBOutlet weak var placeFeedbackBtn: UIButton!
    
    var newPlace:NewPlace = NewPlace()
    var images:[UIImage]?
    
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
    
    @IBAction func unwindToAddNewPlaceVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? AddFeedbackTableViewController
        if let imageArr = sourceViewController?.photosArr {
            if let _ = images{
                images?.append(contentsOf: imageArr)
            } else {
                images = imageArr
            }
        }
        
        if let experienceText = sourceViewController?.experienceTxt {
            self.newPlace.comment = experienceText
            self.placeFeedbackBtn.titleLabel?.text = experienceText
        }
        
    }
    
}
