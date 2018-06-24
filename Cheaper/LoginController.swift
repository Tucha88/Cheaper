//
//  LoginController.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginController: UIViewController {
  
    

    @IBOutlet weak var FacebookLoginBtn: UIButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var LoginText: UiTextFieldExt!
    @IBOutlet weak var PasswordText: UiTextFieldExt!
    @IBOutlet weak var SingInBtn: UIButtonViewExt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FacebookLoginBtn.readPermissions = ["public_profile","email","user_friends"]
//        FacebookLoginBtn.delegate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }    
  
    @IBAction func loginFacebookPressed(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
   
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    print(FBSDKAccessToken.current().tokenString)
                    self.performSegue(withIdentifier: "LoginToMainTabController", sender: nil)
                }
            })
        }
    }
    
   
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("login atempt")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout atempt")
    }
    
    func personalyesAlert(alertTitle : String, alertMessage : String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
}
