//
//  AddNewPlaceController.swift
//  Cheaper
//
//  Created by Admin on 20/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import Cloudinary

class AddNewPlaceController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    @IBOutlet weak var CoffeeSwitch: UISwitch!
    @IBOutlet weak var KosherSwitch: UISwitch!
    @IBOutlet weak var DiscountSwitch: UISwitch!
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeFeedbackBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    var newPlace:NewPlace = NewPlace()
    var images:[UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //delegates
        placeName.delegate = self
        
    }
    
    @IBAction func submitNewPlace(_ sender: UIButton) {
        
        if let image = images{
           dismiss()
        }else{
            dismiss()

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
                                self.newPlace.images.append(url)
                            }else{
                                //Add error handling
                            }
                        })
                        
                    }
                })
            }
            if let experienceText = sourceViewController?.experienceTxt {
                DispatchQueue.main.async {
                    self.newPlace.comment = experienceText
                    self.placeFeedbackBtn.titleLabel?.text = experienceText
                    self.placeFeedbackBtn.isUserInteractionEnabled = true
                    self.submitBtn.titleLabel?.text = "Please wait"
                    self.submitBtn.isUserInteractionEnabled = true
                }
            }
            
        }
        

        
    }
    
}
