//
//  CustomError.swift
//  CheaperApp
//
//  Created by 11111 on 15/01/2018.
//  Copyright © 2018 11111. All rights reserved.
//

import Foundation
struct CustomError : Decodable,Encodable {
    let field : String
    let value : String
    let message : String
}
