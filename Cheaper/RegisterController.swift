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
    
    @IBOutlet weak var EmailLoginText: UITextField!
    @IBOutlet weak var PasswordLoginText: UITextField!
    @IBOutlet weak var PasswordCheck: UITextField!
    @IBOutlet weak var NickNameText: UITextField!
    
    var emailText : String = ""
    var passwordText : String = ""
    var passwordTextCheck : String = ""
    var nickNameTextCheck : String = ""
    
//    struct CustomError : Decodable,Encodable {
//        let field : String
//        let value : String
//        let message : String
//    }
    
    struct Token : Decodable, Encodable {
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
        registrationFunc()
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
    
    func registrationFunc() {

        let parameters : Parameters = ["username" : emailText,
                                       "password" : passwordText,
                                       "name" : nickNameTextCheck]
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
    
    func personalyesAlert(alertTitle : String, alertMessage : String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    
    @IBAction func facebookRegisterAction(_ sender: UIButton) {
    }
    
}
