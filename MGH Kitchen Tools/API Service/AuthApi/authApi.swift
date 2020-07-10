//
//  authApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class authApi: NSObject {
    
    class func login(email: String,password: String, completion: @escaping(_ error: Error?,_ success: Bool, _ userData: Auth?,_ statusCode: Int?)-> Void){
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let url = URLs.login
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    if response.response?.statusCode == 200 {
                        let register = try JSONDecoder().decode(Auth.self, from: response.data!)
                        helperAuth.saveAPIToken(token: register.accessToken ?? "")
                        completion(nil,true,register,response.response?.statusCode)
                    }else {
                        completion(nil,true,nil,response.response?.statusCode)
                    }
                    
                    
                }catch{
                    print("error")
                }
            }
        }
    }
    
    
    class func register(full_name: String, email: String,phone: String,password: String,password_confirmation: String, completion: @escaping(_ error: Error?,_ success: Bool,_ authFiller: AuthFiler?, _ userData: Auth?,_ statusCode: Int?)-> Void){
        
        let parameters = [
            "full_name": full_name,
            "email": email,
            "phone": phone,
            "password": password,
            "password_confirmation": password_confirmation,
            "gender": "male",
            "requestType": "create"
        ]
        
        let url = URLs.signupCustomer
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    if response.response?.statusCode == 200 {
                        let register = try JSONDecoder().decode(Auth.self, from: response.data!)
                        helperAuth.saveAPIToken(token: register.accessToken ?? "")
                        completion(nil,true,nil,register,response.response?.statusCode)
                    }else {
                        let registerFiler = try JSONDecoder().decode(AuthFiler.self, from: response.data!)
                        if registerFiler.success == false {
                            completion(nil,true,registerFiler,nil,response.response?.statusCode)
                        }
                    }
                    
                    
                }catch{
                    print("error")
                }
            }
        }
    }
}
