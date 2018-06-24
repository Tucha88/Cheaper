//
//  HttpProvider.swift
//  Cheaper
//
//  Created by 11111 on 21/06/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
import Alamofire

struct HttpProvider {
    let baseUrl:String = "http://52.29.111.199:8080/"
    
    func registerUser(url:ApiURL,parameters:Parameters,returnError:@escaping (_ message : String)->Void,complition:@escaping (_ message:Data)->Void) -> Void {
        guard let urlFull = URL(string: baseUrl + url.rawValue) else {
            returnError("Wrong url")
            return
        }
        Alamofire.request(urlFull,method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : ["Content-Type":"application/json"])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(String(describing: response.result.error))
                    guard let code = response.response?.statusCode else{
                        return
                    }
                    if code >= 400 && code < 409 {
                        do{
                            let message = try JSONDecoder().decode([CustomError].self, from: response.data!)
                            print(message)
                            returnError(message[0].field + " " + message[0].value + " " + message[0].message)
                            return
                        }catch let error{
                            print(error)
                        }
                    }
                    else if code == 409 {
                        do{
                            let message = try JSONDecoder().decode(CustomError.self, from: response.data!)
                            returnError(message.field + " " + message.value + " " + message.message)
                            return
                        }catch let error{
                            print(error)
                        }
                    }
                    return
                }
                guard let result = response.data else {
                    returnError("There is no return data")
                    return
                }
                complition(result)
                return
                
        }
    }
}
