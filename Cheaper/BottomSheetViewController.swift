//
//  BottomSheetViewController.swift
//  TestBottomDrawer
//
//  Created by 11111 on 28/04/2018.
//  Copyright © 2018 YryApps. All rights reserved.
//

import UIKit
import Pulley
import CloudKit

class BottomSheetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.feedbackView.placeImageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCellID", for: indexPath as IndexPath) as! ImageViewCell
        
        cell.imageView.image = imagesArray[indexPath.row]
        return cell
    }
    
    
    
    
    var cheaperPlaceFeedback:[PlaceFeedback]?
    var cheaperPlaceInfo:CheaperPalce?
    @IBOutlet var feedbackView: CheaperPlaceFeedbackUIView!
    var imagesArray = [UIImage]()
    let myCellName = "ImageViewCell"
    
    
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
        self.feedbackView.onClickCallback = {
            self.clearView()
        }
        self.feedbackView.placeImageCollectionView.register(UINib.init(nibName: myCellName, bundle: nil), forCellWithReuseIdentifier: "ImageViewCellID")
        
        self.feedbackView.placeFeedbackTableView.delegate = self
        self.feedbackView.placeFeedbackTableView.dataSource = self
        self.feedbackView.placeImageCollectionView.delegate = self
        self.feedbackView.placeImageCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.transferToPlaceInfo, object: nil, queue: OperationQueue.main) { (notification) in
            self.clearView()
            let notification = notification.object as! PlaceAndFeedback
            self.fillViewInfo(info: notification)
            let drawer = self.parent as? PulleyViewController
            drawer?.setDrawerPosition(position: .partiallyRevealed, animated: true)
            
            self.cheaperPlaceFeedback?.forEach({
                feedbeck in
                feedbeck.gallery.forEach({
                    url in
                    HttpProvider().downloadImgSingl(url: url, errorComp: {
                        error in
                        print("there is no image")
                    }, complition: {
                        image in
                        self.imagesArray.append(image)
                        DispatchQueue.main.async { // Correct
                            self.reloadImageView()
                        }
                        
                    })
                    
                })
                
            })
        }
    }
    func reloadImageView() {
        self.feedbackView.placeImageCollectionView.reloadData()
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

extension BottomSheetViewController:PulleyDrawerViewControllerDelegate{
    
    func addPlace() {
    }
    
    
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 0 + bottomSafeArea
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        return 200 + bottomSafeArea
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
        
        if drawer.drawerPosition == .collapsed
        {
            drawer.setDrawerPosition(position: .closed, animated: false)
            self.clearView()
        }
        
    }
    
    func clearView() {
        let drawer = self.parent as? PulleyViewController
        drawer?.setDrawerPosition(position: .closed, animated: true)
        self.cheaperPlaceInfo = nil
        self.cheaperPlaceFeedback = nil
        self.feedbackView.placeFeedbackTableView.reloadData()
        self.feedbackView.placeImageCollectionView.reloadData()
        self.imagesArray = [UIImage]()
    }
    
    
    
}
