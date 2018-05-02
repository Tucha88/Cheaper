//
//  GradientView.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {

    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }

    override class var layerClass: AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor,SecondColor.cgColor]
        
    }
}
