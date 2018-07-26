//
//  NewPlace.swift
//  Cheaper
//
//  Created by Admin on 21/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
struct NewPlace:Codable {
    var name:String
    var lat:Double
    var lng:Double
    var images:[String]
    var tag:[String]
    var like:Int
    var comment:String
    var userNickname:String
    
    init() {
        name = String()
        lat = Double()
        lng = Double()
        images = [String()]
        tag = [String()]
        like = Int()
        comment = String()
        userNickname = String()
    }
}
