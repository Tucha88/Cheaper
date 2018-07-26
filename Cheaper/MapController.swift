//
//  MapController.swift
//  Cheaper
//
//  Created by 11111 on 14/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import CoreLocation
import Pulley

protocol FeedbackViewControllerDelegate: class {
    func feedbackViewSetInfo(cheaperPlaseFeedback:[PlaceFeedback],cheaperPlaceInfo:CheaperPalce)
}


class MapController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    var location : CLLocation!
    var message:[CheaperPalce]?
    var cheaperPlaseFeedback:[PlaceFeedback]?
    var cheaperPlaceInfo:CheaperPalce?
    //propertis of placeInfo
    
    var coordinates:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        mapView.isMyLocationEnabled = true
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        let drawer = self.parent as? PulleyViewController
        drawer?.setDrawerPosition(position: .closed, animated: false)
        let bottomSheet = drawer?.drawerContentViewController as! BottomSheetViewController
        bottomSheet.addPlace()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mapView)
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        location = locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView.camera = camera
        onSendPostRequest()
    }
    
    
    
    func showCheperPlace(place:CheaperPalce?){
        guard let url = URL(string: "http://52.29.111.199:8080/dev/places/info?jukeId="+(place?.id)!) else {return}
        Alamofire.request(url,method : .get, encoding: JSONEncoding.default, headers : ["Content-Type":"application/json"]).responseJSON { response in
            let result = response.data!
            print(result)
            guard let code = response.response?.statusCode else{
                return
            }
            if code == 400 {
                do{
                    let message = try JSONDecoder().decode([CustomError].self, from: response.data!)
                    print(message[0])
                    return
                }catch let error{
                    print(error)
                    return
                }
            } else if code == 200{
                do{
                    let message = try JSONDecoder().decode([PlaceFeedback].self, from: response.data!)
                    self.cheaperPlaseFeedback = nil
                    self.cheaperPlaseFeedback = message
                    self.cheaperPlaceInfo = place
                    
                    NotificationCenter.default.post(name: .transferToPlaceInfo, object: PlaceAndFeedback.init(place: place!, feedback: message))
                    return
                }catch let error{
                    print(error)
                    return
                }
            }
        }
    }
    
    
    
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        showCheperPlace(place: marker.userData as? CheaperPalce)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func onSendPostRequest(){
        guard let url = URL(string: "http://52.29.111.199:8080/dev/places/near") else {return}
        
        let postDictionary:Parameters = ["lat" : Double(round(1000*location.coordinate.latitude)/1000),
                                         "lng" : Double(round(1000*location.coordinate.longitude)/1000),
                                         "dist" : 150]
        Alamofire.request(url,method : .post, parameters: postDictionary, encoding: JSONEncoding.default, headers : ["Content-Type":"application/json"]).responseJSON { response in
            guard let code = response.response?.statusCode else{
                print("Error: cannot create URL")
                return
            }
            if code >= 400 {
                do{
                    let message = try JSONDecoder().decode([CustomError].self, from: response.data!)
                    print(message[0])
                    return
                }catch let error{
                    print(error)
                }
            }
            if code == 200 {
                do{
                    self.message = try JSONDecoder().decode([CheaperPalce].self, from: response.data!)
                    guard let message = self.message else {return}
                    self.mapView.clear()
                    for i in 0..<message.count{
                        guard let lat = message[i].lat else {
                            return
                        }
                        guard let lng = message[i].lng else {
                            return
                        }
                        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                        let marker = GMSMarker(position: position)
                        marker.title = message[i].name
                        marker.userData = message[i]
                        marker.isTappable = true
                        marker.icon = UIImage(named: "Pin")
                        marker.map = self.mapView
                    }
                }catch let error{
                    print(error)
                    return
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MapController{
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.coordinates = coordinate
        performSegue(withIdentifier: "addPlace", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addNewPlaceVC = segue.destination as? AddNewPlaceController else { return }
        let coordinate = coordinates 
        addNewPlaceVC.newPlace.lng = coordinate.longitude
        addNewPlaceVC.newPlace.lat = coordinate.latitude
    }
}


