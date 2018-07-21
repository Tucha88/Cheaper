//
//  FirstWelcomeController.swift
//  Cheaper
//
//  Created by 11111 on 12/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class FirstWelcomeController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toSecondWelcome(_ sender: UIButtonViewExt) {
        self.performSegue(withIdentifier: "toSecond", sender: self)
    }
    
    
}
