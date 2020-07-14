//
//  aboutUsApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class aboutUsApi: NSObject {
    class func aboutUsApi(completion: @escaping(_ error: Error?,_ success: Bool,_ product: aboutUs?)-> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang
        ]
        
        let parameters = [
            "pageName": "about"
        ]
        let url = URLs.staticPages
        print(headers)
        print(url)
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let product = try JSONDecoder().decode(aboutUs.self, from: response.data!)
                    if product.success == true {
                        completion(nil,true,product)
                    }else {
                        completion(nil,true,product)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
    
    class func contactUsApi(name: String,email: String,phone:String,message: String ,completion: @escaping(_ error: Error?,_ success: Bool,_ cart: Messages?)-> Void){
        
        let parametars = [
            "name": name,
            "email": email,
            "phone": phone,
            "message": message
        ]
        print(parametars)
        
        AF.request(URLs.contactUs, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(Messages.self, from: response.data!)
                    if cart.success == true {
                        completion(nil,true,cart)
                    }else {
                        completion(nil,true,cart)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
