//
//  RegisterController.swift
//  Cheaper
//
//  Created by 11111 on 18/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import Alamofire

class RegisterController: UIViewController {
    
    
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var FacebookRegisterBtn: UIButton!
    @IBOutlet weak var googleRegisterBtn: UIButton!
    
    @IBOutlet weak var EmailLoginText: UITextField!
    @IBOutlet weak var PasswordLoginText: UITextField!
    @IBOutlet weak var PasswordCheck: UITextField!
    @IBOutlet weak var NickNameText: UITextField!
    
    var emailText : String = ""
    var passwordText : String = ""
    var passwordTextCheck : String = ""
    var nickNameTextCheck : String = ""
    
    
    struct Token : Codable {
        let token : String
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginFunction(_ sender: Any) {
        if !isTextFieldsProper() {
            return
        }
        registrationFunc(email: emailText, password: passwordText, nikName: nickNameTextCheck)
    }
    
    
    func isTextFieldsProper() -> Bool {
        emailText = EmailLoginText.text ?? ""
        passwordText = PasswordLoginText.text ?? ""
        passwordTextCheck = PasswordCheck.text ?? ""
        nickNameTextCheck = NickNameText.text ?? ""
        if emailText.isEmpty  {
            personalyesAlert(alertTitle: "No Email entered", alertMessage: "Enter your email")
            return false
        }
        if passwordText.isEmpty  {
            personalyesAlert(alertTitle: "No Password entered", alertMessage: "Enter your password")
            return false
        }
        if passwordText.count < 6  {
            personalyesAlert(alertTitle: "Wrond password", alertMessage: "Password must be longer than 6 characters")
            return false
        }
        if passwordTextCheck.isEmpty || passwordText.count != passwordTextCheck.count ||  passwordText != passwordTextCheck{
            personalyesAlert(alertTitle: "Wrond password", alertMessage: "Enter saame password twice")
            return false
        }
        if nickNameTextCheck.isEmpty {
            personalyesAlert(alertTitle: "enter", alertMessage: "Enter saame password twice")
            return false
        }
        return true
    }
    
    
    
    
  
    
    
    @IBAction func facebookRegisterAction(_ sender: UIButton) {
        facebookRegister()
    }
    @IBAction func googleRegisterAction(_ sender: UIButton) {
    }
    
    
}

import FBSDKLoginKit
extension RegisterController {
    
    func facebookRegister() {
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
                    let newUser : UserProfile = UserProfile.init(email: userData["email"] as! String, name: userData["name"] as! String, tags:[], photo: "")
                    let encodedData = try? JSONEncoder().encode(newUser)
                    preferences.set(encodedData,forKey: "userProfile")
                    preferences.synchronize()
                    self.registrationFunc(email: newUser.email, password: newUser.email, nikName: newUser.name)
                    
                }
            })
        }
    }
    
}

extension RegisterController {
    func personalyesAlert(alertTitle : String, alertMessage : String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
}

extension RegisterController {
    
    func registrationFunc(email:String, password:String, nikName:String) {
       
        let parameters : Parameters = ["username" : email,
                                       "password" : password,
                                       "name" : nikName]
        let httpProv = HttpProvider()
        httpProv.registerUser(url: .REGISTERUSER, parameters: parameters, returnError: {error in
            self.personalyesAlert(alertTitle: "Registration error", alertMessage: error)
        }, complition: {result in
            let preferences = UserDefaults.standard
            do{
                let token = try JSONDecoder().decode(Token.self, from: result)
                let tokenKey = "token"
                preferences.set(token.token, forKey: tokenKey)
                preferences.synchronize()
                self.performSegue(withIdentifier: "RegisterToMainMap", sender: nil)
                return
            } catch let error{
                self.personalyesAlert(alertTitle: "Token decoding error", alertMessage: error.localizedDescription)
                
            }
        })
        
        
        
    }
}
