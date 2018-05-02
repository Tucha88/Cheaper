//
//  CheaperPlaceViewController.swift
//  Cheaper
//
//  Created by 11111 on 20/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class CheaperPlaceViewController: UIView {

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var placeDiraction: UILabel!
    @IBOutlet weak var placeTimeOfWork: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var placeImageCollection: UICollectionView!
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
        Bundle.main.loadNibNamed("CheaperPlaceViewController", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
 
        
        
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
