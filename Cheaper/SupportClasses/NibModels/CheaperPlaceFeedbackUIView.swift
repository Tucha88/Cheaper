//
//  CheaperPlaceFeedbackUIView.swift
//  Cheaper
//
//  Created by 11111 on 23/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class CheaperPlaceFeedbackUIView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placeLikes: UILabel!
    @IBOutlet weak var placeDislikes: UILabel!
    @IBOutlet weak var placeOpenTime: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var placeImageCollectionView: UICollectionView!
    @IBOutlet weak var placeFeedbackTableView: UITableView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup()
    {
        Bundle.main.loadNibNamed("CheaperPlaceFeedbackView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }

}
