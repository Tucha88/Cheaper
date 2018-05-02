//
//  WelcomeFirstTimeController.swift
//  Cheaper
//
//  Created by 11111 on 08/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit

class WelcomeFirstTimeController: UIViewController {

    @IBOutlet weak var pageControlView: UIPageControl!
    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var logoIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //pageControlView.currentPage = 0
    }


//    @IBAction func nextView(_ sender: UIButtonViewExt) {
//        switch pageControlView.currentPage {
//        case 0:
//            logoIcon.image = UIImage(named: "AddPlaceIcon")
//            textLable.text = "Add your favourite places"
//            pageControlView.currentPage+=1
//            break
//        case 1:
//            logoIcon.image = UIImage(named: "FeedbackIcon")
//            textLable.text = "Leave your feedback"
//            pageControlView.currentPage+=1
//            break
//        case 2:
//
//            break
//        default:
//            break
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
