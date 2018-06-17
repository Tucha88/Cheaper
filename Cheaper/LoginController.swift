//
//  LoginController.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
class LoginController: UIViewController {

    @IBOutlet weak var FacebookLoginBtn: FBSDKButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var LoginText: UiTextFieldExt!
    @IBOutlet weak var PasswordText: UiTextFieldExt!
    @IBOutlet weak var SingInBtn: UIButtonViewExt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }    
  

}
