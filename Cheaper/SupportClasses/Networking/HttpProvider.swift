//
//  HttpProvider.swift
//  Cheaper
//
//  Created by 11111 on 21/06/2018.
//  Copyright © 2018 YriApps. All rights reserved.
//

import Foundation
import Alamofire
import Cloudinary

class HttpProvider:NSObject {
    let baseUrl:String = "http://52.29.111.199:8080/"
    var config = CLDConfiguration(cloudName: "cheaperapp", apiKey: "653687966656237")
    var cloudinary:CLDCloudinary! = nil
    
    func downloadImgSingl(url:String,errorComp:@escaping (_ message : String)->Void,complition:@escaping (_ message:UIImage)->Void) -> Void{
        cloudinary = CLDCloudinary(configuration: config)
        let downloader:CLDDownloader = cloudinary.createDownloader()
        downloader.fetchImage(url, { progress in
            // Handle progress
        }) { (responseImage, error) in
            // responseImage is an instance of UIImage
            // error is an instance of NSError
            guard let responseImage = responseImage else {
                errorComp("Could not get image")
                return
            }
            complition(responseImage)
        }
        
        
    }
    
    
    func loginUser(url:ApiURL,parameters:Parameters,returnError:@escaping (_ message : String)->Void,complition:@escaping (_ message:Data)->Void) -> Void{
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
                    if code >= 400 && code < 401 {
                        do{
                            let message = try JSONDecoder().decode([CustomError].self, from: response.data!)
                            returnError(message[0].field + " " + message[0].value + " " + message[0].message)
                            return
                        }catch let error{
                            returnError(error.localizedDescription)
                        }
                    }
                    else if code == 401 {
                        returnError("Wrong email or password")
                        return
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
    
    func addNewPlace(parameters:Parameters,token : String, returnError:@escaping(_ message:String)->Void,complition:@escaping(_ message:Data)->Void) -> Void {
        guard let url = URL(string: baseUrl + ApiURL.ADDBAR.rawValue) else {
            returnError("Could not get url")
            return
        }
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers : ["Content-Type":"application/json", "Authorization": token])
            .validate()
            .responseJSON { response in
                guard response.result.isFailure else{
                    
                    print(String(describing: response.result.error))
                    guard let code = response.response?.statusCode else{
                        return
                    }
                    if code >= 400 && code < 409 {
                        do{
                            let message = try JSONDecoder().decode([CustomError].self, from: response.data!)
                            returnError(message[0].field + " " + message[0].value + " " + message[0].message)
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
                guard let code = response.response?.statusCode else{
                    return
                }

                print(code)
                complition(result)
                return
                
        }
        
    }
}
