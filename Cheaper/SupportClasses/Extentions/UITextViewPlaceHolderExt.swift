//
//  UITextViewPlaceHolderExt.swift
//  Cheaper
//
//  Created by 11111 on 18/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
@IBDesignable
class UITextViewPlaceHolderExt: UITextView,UITextViewDelegate {

    @IBInspectable var Placeholder:String = ""{
        didSet{
            updateView()
        }
    }
    func updateView() {
        self.delegate = self
        self.text = Placeholder
        self.textColor = UIColor.lightGray
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    

}
