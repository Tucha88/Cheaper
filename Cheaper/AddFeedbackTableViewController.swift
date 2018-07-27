//
//  AddFeedbackTableViewController.swift
//  Cheaper
//
//  Created by Admin on 21/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class AddFeedbackTableViewController: UITableViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var experienceText: UITextViewPlaceHolderExt!
    
    var experienceTxt = ""
    var photosArr:[UIImage]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegetes
        experienceText.delegate = self
        
    }
    
    @IBAction func addPhotos(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func addLike(_ sender: UIButton) {
    }
    @IBAction func addDislike(_ sender: UIButton) {
    }
    @IBAction func submiteYourExperinece(_ sender: Any) {
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let _ = photosArr{
            photosArr?.append(image)
        } else {
            photosArr = [image]
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        experienceTxt = experienceText.text
    }
}
