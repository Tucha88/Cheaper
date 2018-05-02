//
//  BottomSheetViewController.swift
//  TestBottomDrawer
//
//  Created by 11111 on 28/04/2018.
//  Copyright © 2018 YryApps. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var cheaperPlaceFeedback:[PlaceFeedback]?
    var cheaperPlaceInfo:CheaperPalce?
    @IBOutlet var feedbackView: CheaperPlaceFeedbackUIView!

    
    func dateFormater(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateMain = formatter.string(from: date)
        formatter.timeStyle = .short
        return dateMain
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cheaperPlaceFeedback?.count) ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CheaperPlaceFeedbackTableViewCell", owner: self, options: nil)?.first as! CheaperPlaceFeedbackTableViewCell
        
        
        cell.nameText.text = cheaperPlaceFeedback![indexPath.row].userNickname
        cell.feedbackText.text = cheaperPlaceFeedback![indexPath.row].text
        cell.dateText.text = dateFormater(date: cheaperPlaceFeedback![indexPath.row].time)
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedbackView.placeFeedbackTableView.delegate = self
        self.feedbackView.placeFeedbackTableView.dataSource = self
        NotificationCenter.default.addObserver(forName: NSNotification.Name.transferToPlaceInfo, object: nil, queue: OperationQueue.main) { (notification) in
            let notification = notification.object as! PlaceAndFeedback
            self.fillViewInfo(info: notification)
        }
    }
    
    func fillViewInfo(info:PlaceAndFeedback) -> Void {
        let cheaperPlaceInfo = info.placeInfo
        self.feedbackView.placeName.text = cheaperPlaceInfo?.name
        self.feedbackView.placeDescription.text = cheaperPlaceInfo?.description
        self.feedbackView.placeDislikes.text = "\(cheaperPlaceInfo?.dislikes ?? 0)"
        self.feedbackView.placeLikes.text = "\(cheaperPlaceInfo?.likes ?? 0)"
        self.cheaperPlaceFeedback = nil
        self.cheaperPlaceFeedback = info.feedbackInfo
        self.feedbackView.placeFeedbackTableView.reloadData()
    }
   

    
}