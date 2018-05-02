//
//  UIButtonViewExt.swift
//  Cheaper
//
//  Created by 11111 on 09/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
@IBDesignable
class UIButtonViewExt: UIButton {

    @IBInspectable var cornerRadius:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor:UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
}
