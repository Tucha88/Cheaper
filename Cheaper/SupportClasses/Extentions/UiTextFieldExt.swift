//
//  UiTextFieldExt.swift
//  Cheaper
//
//  Created by 11111 on 13/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
@IBDesignable
class UiTextFieldExt: UITextField {
    @IBInspectable var BorderColor:UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var BorderWidth:CGFloat=0 {
        didSet{
            updateView()
        }
    }
    @IBInspectable var BorderFrameX:CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    private func updateView(){
        let border = CALayer()
        
        border.borderColor = BorderColor.cgColor
        border.borderWidth = BorderWidth
        border.frame = CGRect(x: BorderFrameX, y: bounds.size.height - BorderWidth, width: bounds.size.width, height: bounds.size.height)
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
  
}
