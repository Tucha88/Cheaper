//
//  UserProfile.swift
//  Cheaper
//
//  Created by 11111 on 24/06/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
struct UserProfile: Codable{
    
    let email:String
    let name:String
    let tags:[String]
    let photo:String
    
    init(email:String,name:String,tags:[String],photo:String) {
        self.email = email
        self.name = name
        self.tags = tags
        self.photo = photo
    }
    init() {
        self.email = ""
        self.name = ""
        self.tags = [""]
        self.photo = ""
    }
    
}
