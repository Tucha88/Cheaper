//
//  ReturnMessage.swift
//  CheaperApp
//
//  Created by 11111 on 25/01/2018.
//  Copyright © 2018 11111. All rights reserved.
//

import Foundation
struct ReturnMessage: Decodable,Encodable  {
    let token:String
    let profile:UserProfile
}
