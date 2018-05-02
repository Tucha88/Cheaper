//
//  PlaceAndFeedback.swift
//  Cheaper
//
//  Created by 11111 on 29/04/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
struct PlaceAndFeedback: Decodable,Encodable {
    
    let placeInfo : CheaperPalce!
    let feedbackInfo : [PlaceFeedback]!
    init(place : CheaperPalce, feedback : [PlaceFeedback]) {
        placeInfo = place
        feedbackInfo = feedback
    }
    
}
