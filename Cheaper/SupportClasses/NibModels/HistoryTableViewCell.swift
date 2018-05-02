//
//  HistoryTableViewCell.swift
//  Cheaper
//
//  Created by 11111 on 19/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var PlaceHistoryImageIcon: UIImageView!
    
    @IBOutlet weak var PlaceHistoryNameText: UILabel!
    
    @IBOutlet weak var PlaceHistoryImageDesctiption: UILabel!
    
    @IBOutlet weak var PlaceHistoryDirections: UILabel!
    @IBOutlet weak var PlaceHistoryLikeCounter: UILabel!
    
    @IBOutlet weak var PlaceHistoryDislikeCounter: UILabel!
    
    @IBOutlet weak var HistoryLikeButton: UIButton!
    
    @IBOutlet weak var HistoryDislikeButton: UIButton!
    
    @IBOutlet weak var HistoryDateText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
