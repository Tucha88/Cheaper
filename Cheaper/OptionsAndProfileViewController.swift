//
//  OptionsAndProfileViewController.swift
//  Cheaper
//
//  Created by 11111 on 25/06/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit

class OptionsAndProfileViewController: UITableViewController {
    
    @IBOutlet weak var imagePlaceholder: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var vegeterianSwitch: UISwitch!
    @IBOutlet weak var coffeeSwitch: UISwitch!
    @IBOutlet weak var kosherSwitch: UISwitch!
    @IBOutlet weak var soldierDiscountSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard
        
        if let string = preferences.object(forKey: "userProfile") as? Data{
            if let userProfile = try? JSONDecoder().decode(UserProfile.self, from: string){
                print("OptionsAndProfileViewController - got the data of user in")
                nameText.text = userProfile.name
                emailText.text = userProfile.email
                
            }
        }   
        
    }
    
    //implemet logout routine
    @IBAction func logoutAction(_ sender: Any) {
        let preferences = UserDefaults.standard
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        preferences.removeObject(forKey: "token")
        preferences.removeObject(forKey: "userProfile")
        preferences.synchronize()
        performSegue(withIdentifier: "toWelcomeController", sender: self)
    }
    
    
    
}
