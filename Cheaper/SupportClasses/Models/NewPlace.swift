//
//  NewPlace.swift
//  Cheaper
//
//  Created by Admin on 21/07/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
struct NewPlace:Codable {
    let name:String
    let lat:Float
    let lng:Float
    let images:[String]
    let tag:[String]
    let like:Int
    let comment:String
    let userNickname:String
}
