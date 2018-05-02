//
//  CheaperPalce.swift
//  CheaperApp
//
//  Created by 11111 on 31/12/2017.
//  Copyright © 2017 11111. All rights reserved.
//


struct CheaperPalce : Encodable,Decodable {
    let id : String!
    let name : String?
    let lat : Double!
    let lng : Double!
    let description : String?
    let googleId : String?
    let tags : [String?]
    let likes : Int?
    let dislikes : Int?
    }


