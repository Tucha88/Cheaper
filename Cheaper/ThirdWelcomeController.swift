//
//  ThirdWelcomeController.swift
//  Cheaper
//
//  Created by 11111 on 12/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class ThirdWelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToBegining(_ sender: UIButtonViewExt) {
        self.performSegue(withIdentifier: "unwindeToBegin", sender: self)
    }
  
}
