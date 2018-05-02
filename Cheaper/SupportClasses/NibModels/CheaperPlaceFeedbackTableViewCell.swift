//
//  CheaperPlaceFeedbackTableViewCell.swift
//  Cheaper
//
//  Created by 11111 on 21/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class CheaperPlaceFeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var feedbackText: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showMore(_ sender: UIButton) {
    }
}
