//
//  ApiURL.swift
//  Cheaper
//
//  Created by 11111 on 21/06/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
enum ApiURL:String {
    case ADDBAR = "/dev/places/add"
    case ADDREVIEW = "/dev/places/relate"
    case REGISTERUSER = "/users"
    case CHANGEROLE = "/changerole"
    case FINDBAR = "/dev/places/near"
    case FINDBARINFO = "/dev/places/info"
    case FINDNEXTREVIEW = "/nextreview"
    case FINDREVIEW = "/dev/places/feedback"
    case FINDUSER = "/finduser"
    case LOGIN = "/users/login"
}


