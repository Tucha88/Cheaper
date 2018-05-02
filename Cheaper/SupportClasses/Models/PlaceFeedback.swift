//
//  PlaceInfo.swift
//  CheaperApp
//
//  Created by 11111 on 25/01/2018.
//  Copyright © 2018 11111. All rights reserved.
//
import Foundation
struct PlaceFeedback: Decodable,Encodable {
    
    let jukeid:String
    let jukeName:String
    let username:String
    let userNickname:String
    var time:Date
    let like:Int32
    let text:String
    let gallery:[String]
   
}
