//
//  LoginController.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire

class LoginController: UIViewController,UITextFieldDelegate {
    
    struct LoginUser:Codable {
        let token:String
        let profile:UserProfile
    }
    
    
    @IBOutlet weak var FacebookLoginBtn: UIButton!
    @IBOutlet weak var GoogleLoginBtn: UIButton!
    @IBOutlet weak var LoginText: UiTextFieldExt!
    @IBOutlet weak var PasswordText: UiTextFieldExt!
    @IBOutlet weak var SingInBtn: UIButtonViewExt!
    
    var emailText : String = ""
    var passwordText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        FacebookLoginBtn.readPermissions = ["public_profile","email","user_friends"]
        //        FacebookLoginBtn.delegate = self
        
        PasswordText.delegate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if !isTextFieldsProper(){
            return
        }
        let parameters : Parameters = ["username" : emailText,
                                       "password" : passwordText]
        let httpProv = HttpProvider()
        httpProv.loginUser(url: .LOGIN, parameters: parameters, returnError:
            {error in
                self.personalyesAlert(alertTitle: "Login error", alertMessage: error)
                
        }, complition: {result in
            let preferences = UserDefaults.standard
            do{
                let token = try JSONDecoder().decode(LoginUser.self, from: result)
                let tokenKey = "token"
                let encodedData = try? JSONEncoder().encode(token.profile)
                
                preferences.set(encodedData,forKey: "userProfile")
                
                
                preferences.set(token.token, forKey: tokenKey)
                preferences.synchronize()
                self.performSegue(withIdentifier: "LoginToMainTabController", sender: nil)
                return
            } catch let error{
                self.personalyesAlert(alertTitle: "Token decoding error", alertMessage: error.localizedDescription)
                
            }
        })
        
    }
    
    func isTextFieldsProper() -> Bool {
        emailText = LoginText.text ?? ""
        passwordText = PasswordText.text ?? ""
        if emailText.isEmpty  {
            personalyesAlert(alertTitle: "No Email entered", alertMessage: "Enter your email")
            return false
        }
        if passwordText.isEmpty  {
            personalyesAlert(alertTitle: "No Password entered", alertMessage: "Enter your password")
            return false
        }
        return true
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
                    guard let userData = result as? [String:Any] else {
                        //TODO - add error handling
                        return
                    }
                    let preferences = UserDefaults.standard
                    let newUser = UserProfile.init(email: userData["email"] as! String, name: userData["name"] as! String, tags:[], photo: "")
                    let encodedData = try? JSONEncoder().encode(newUser)
                    print(encodedData)
                    preferences.set(encodedData,forKey: "userProfile")
                    preferences.synchronize()
                    
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
    // keyboard "done" button to hide it
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
