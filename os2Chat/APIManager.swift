//
//  APIManager.swift
//  os2Chat
//
//  Created by Mingu Chu on 4/24/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIManager {
    
    static let sharedInstance = APIManager()
    
    let baseUrl = "https://private-93240c-oracodechallenge.apiary-mock.com/"
    let contentType = ["Content-Type": "application/json; charset-UTF-8"]
    let contAuthHeader = ["Content-Type": "application/json; charset-UTF-8", "Authorization": "Bearer BBJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"]
    
    
    func register(name: String, email: String, pw: String, confirmPw: String, completion: @escaping (Bool, String) -> ()) {
        let headers: HTTPHeaders = contentType
        let paramters = ["name": name, "email": email, "password":pw, "confirm": confirmPw]
        
        Alamofire.request(baseUrl.appending("users"), method: .post, parameters: paramters, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonValue = JSON(value)
                if let id = jsonValue["data"]["id"].int {
                    guard id == 1 else {
                        completion(false, "Register Error")
                        return
                    }
                }
                completion(true, "Sucessfully Registered")
                
            case .failure(let error):
                print("Register request Error")
                let message = error.localizedDescription
                completion(false, message)
                return
            }
        }
    }
    
    
    func login(email: String, pw: String, completion: @escaping (Bool, String) -> ()) {
        let headers: HTTPHeaders = contentType
        let parameters = ["email": email, "password": pw]
        
        Alamofire.request(baseUrl.appending("auth/login"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonValue = JSON(value)
                if let id = jsonValue["data"]["id"].int {
                    guard id == 1 else {
                        completion(false, "Login Error")
                        return
                    }
                    completion(true, "Sucessfully Loggedin")
                    return
                }
                completion(false, "Login Error")
                return
            case .failure(let error):
                print("Login request Error")
                let message = error.localizedDescription
                completion(false, message)
                return
            }
        }
    }
    
    
    func logout(completion: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = contAuthHeader
        
        Alamofire.request(baseUrl.appending("auth/logout"), method: .get, headers: headers).responseData { (response) in
            switch response.result {
            case .success:
                completion(true)
                
            case .failure:
                completion(false)
                return
            }
        }
    }
    
    
    func readCurrentUser(completion: @escaping (User?) -> (Void)) {
        let headers: HTTPHeaders = contAuthHeader
        
        Alamofire.request(baseUrl.appending("users/current"), method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let value = JSON(value)
                let data = value["data"]
                let user = User(json: data)
                completion(user)
            case .failure:
                return
            }
        }
    }
    
    func updateCurrentUser(name: String, email: String, pw: String, confirmPw: String, completion: @escaping (Bool, String) -> ()) {
        let headers: HTTPHeaders = contentType
        let paramters = ["name": name, "email": email, "password":pw, "confirm": confirmPw]
        
        Alamofire.request(baseUrl.appending("users/current"), method: .patch, parameters: paramters, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonValue = JSON(value)
                if let id = jsonValue["data"]["id"].int {
                    guard id == 1 else {
                        completion(false, "Update Error")
                        return
                    }
                    completion(true, "Sucessfully Updated")
                    return
                }
                completion(false, "Update Error")
                
            case .failure:
                completion(false, "Request Error")
                
            }
        }
    }
    
    func listChat(page: NSNumber, limit: NSNumber, completionHandler: @escaping ([Chat]) -> ()) {
        let headers: HTTPHeaders = contAuthHeader
        let url = baseUrl.appending("chats?page=\(page)&limit=\(limit)")
        
        Alamofire.request(url, method: .get, headers: headers).validate().responseJSON { (response) in
            
            if response.result.isSuccess == true {
                if let value = response.result.value {
                    let jsonValues = JSON(value)["data"]
                    var chatLists:[Chat] = []

                    for (_, value) in jsonValues {
                        let chat = Chat(json: value)
                        chatLists.append(chat)
                    }
                    
                    completionHandler(chatLists)
                }
            }
        }
    }
    
    func createChat(name: String, message: String, completionHandler: @escaping (Bool) -> ()) {
        let headers: HTTPHeaders = contAuthHeader
        let paramaters: Parameters = ["name": name, "message": message]
        
        
        Alamofire.request(baseUrl.appending("chats"), method: .post, parameters: paramaters, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonValue = JSON(value)
                if let id = jsonValue["data"]["id"].int {
                    guard id == 1 else {
                        completionHandler(false)
                        return
                    }
                    completionHandler(true)
                    return
                }
                completionHandler(false)
                
            case .failure:
                completionHandler(false)
                
            }
        }
    }
    
    
    
    
}






































