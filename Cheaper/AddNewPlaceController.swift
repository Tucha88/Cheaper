//
//  AddNewPlaceController.swift
//  Cheaper
//
//  Created by Admin on 20/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import Cloudinary
import Alamofire

class AddNewPlaceController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    @IBOutlet weak var CoffeeSwitch: UISwitch!
    @IBOutlet weak var KosherSwitch: UISwitch!
    @IBOutlet weak var DiscountSwitch: UISwitch!
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeFeedbackBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    var newPlace:NewPlace?
    var images:[UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //delegates
        placeName.delegate = self
        
    }
    
    @IBAction func submitNewPlace(_ sender: UIButton) {
        let preferences = UserDefaults.standard
        guard let placeNameTxt = placeName.text else {
            //TODO - alert to enter place name
            return
        }
        if let string = preferences.object(forKey: "userProfile") as? Data{
            if let userProfile = try? JSONDecoder().decode(UserProfile.self, from: string){
                print("AddnewPlaceController - got the data of user in")
                newPlace?.userNickname = userProfile.name
                newPlace?.name = placeNameTxt
                let switchesArr = [vegetarianSwitch,CoffeeSwitch,KosherSwitch,DiscountSwitch]
                var tags:[String] = []
                for i in 0...3 {
                    let tag = switchesArr[i]?.isOn
                    if tag! {
                        switch i{
                        case 0:
                            tags.append("Vegan")
                        case 1:
                            tags.append("Coffe")
                        case 2:
                            tags.append("Kosher")
                        case 3:
                            tags.append("Soldier")
                        default:
                            break
                        }
                    }
                }
                newPlace?.tag = tags
                
                createNewPlace(newPlaceReq: newPlace!)
            }
        }
        
        
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)    }
    
    
    // keyboard "done" button to hide it
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindToAddNewPlaceVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? AddFeedbackTableViewController
        placeFeedbackBtn.isUserInteractionEnabled = false
        submitBtn.isUserInteractionEnabled = false
        submitBtn.titleLabel?.text = "Please wait"
        DispatchQueue.global(qos: .background).async {
            let cloudinaryConfig = CLDConfiguration(cloudinaryUrl: "cloudinary://653687966656237:IVdF5pJ4andhRqDl44VcVHJt_jQ@cheaperapp")
            let cloudinaryMangaer = CLDCloudinary(configuration: cloudinaryConfig!)
            let preprocessChain = CLDImagePreprocessChain()
                .addStep(CLDPreprocessHelpers.limit(width: 1024, height: 720))
                .addStep(CLDPreprocessHelpers.dimensionsValidator(minWidth: 150, maxWidth: 1024, minHeight: 150, maxHeight: 720))
                .setEncoder(CLDPreprocessHelpers.customImageEncoder(format: .JPEG, quality: 70))
            
            if let imageArr = sourceViewController?.photosArr {
                imageArr.forEach({img in
                    if let imageData = UIImagePNGRepresentation(img){
                        
                        _ = cloudinaryMangaer.createUploader().upload(data: imageData, uploadPreset: "q2gowiis", preprocessChain: preprocessChain).progress({progress in
                            
                        }).response({
                            (response, error) in
                            if let url = response?.url{
                                if let _ = self.newPlace?.images {
                                    self.newPlace?.images?.append(url)
                                }else {
                                    self.newPlace?.images = [url]
                                }
                                self.newPlace?.like = sourceViewController?.likeOrDislike
                                if let experienceText = sourceViewController?.experienceTxt {
                                    DispatchQueue.main.async {
                                        self.newPlace?.comment = experienceText
                                        self.placeFeedbackBtn.titleLabel?.text = experienceText
                                        self.placeFeedbackBtn.isUserInteractionEnabled = true
                                        self.submitBtn.titleLabel?.text = "Please wait"
                                        self.submitBtn.isUserInteractionEnabled = true
                                    }
                                }
                            }else{
                                //Add error handling
                                
                            }
                        })
                        
                    }
                })
            }
            
        }
    }
    
}
extension AddNewPlaceController{
    func createNewPlace(newPlaceReq : NewPlace) {
        let httpProvider = HttpProvider()
        let parameters : Parameters = [
            "name": newPlaceReq.name!,
            "lat": newPlaceReq.lat!,
            "lng": newPlaceReq.lng!,
            "images": newPlaceReq.images!,
            "tags": newPlaceReq.tag!,
            "like": newPlaceReq.like!,
            "comment": newPlaceReq.comment!,
            "userNickname": newPlaceReq.userNickname!
        ]
        print(newPlaceReq)
        httpProvider.addNewPlace(parameters: parameters, returnError: { (error) in
            print(error)
        }) { (response) in
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
