//
//  WelcomeController.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
                let firstLaunch = FirstLaunch(userDefaults: .standard, key: "isFirsLaunch")

                if firstLaunch.isFirstLaunch {
                    print("Hello World")
                     self.performSegue(withIdentifier: "Tutorial", sender: self)
                }

//        Test code for welcome screen
        
        
//        let alwaysFirstLaunch = FirstLaunch(getWasLaunchedBefore: { return false }, setWasLaunchedBefore: { _ in })
//        if alwaysFirstLaunch.isFirstLaunch {
//                self.performSegue(withIdentifier: "Tutorial", sender: self)
//        }
    }
    
    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue"{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }else if segue.identifier == "RegisterSegue"{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }else if segue.identifier == "Tutorial"{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
        
    }
    

  

}
