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
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    
    var experienceTxt = ""
    var photosArr:[UIImage]?
    var likeOrDislike:Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegetes
        experienceText.delegate = self
        
    }
    
    @IBAction func addPhotos(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
       
    }
    @IBAction func addLike(_ sender: UIButton) {
        likeOrDislike = 1
        likeBtn.setImage(UIImage(named: "like_pressed"), for: .normal)
        dislikeBtn.setImage(UIImage(named: "dislike_icon"), for: .normal)
    }
    @IBAction func addDislike(_ sender: UIButton) {
        likeOrDislike = -1
        likeBtn.setImage(UIImage(named: "like_icon"), for: .normal)
        dislikeBtn.setImage(UIImage(named: "dislike_pressed"), for: .normal)
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
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        experienceTxt = experienceText.text
        if identifier == "unwindToAddNewPlaceVC" {
            if likeOrDislike == 0 || experienceTxt == "" || photosArr == nil {
                return false
            }
        }
        return true
    }
}
