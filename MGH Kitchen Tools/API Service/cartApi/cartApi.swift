//
//  cartApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class cartApi: NSObject {
    
    class func cartOption(url: String,product_id: String,qty:String,completion: @escaping(_ error: Error?,_ success: Bool,_ cart: Messages?,_ ErroMesage: sotkeMessage?,_ x: String?)-> Void){
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil,nil,nil)
            return
        }
        
        let parametars = [
            "product_id": product_id,
            "qty": qty
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(Messages.self, from: response.data!)
                    if cart.success == true {
                        completion(nil,true,cart,nil,nil)
                    }else {
                        completion(nil,true,cart,nil,nil)
                    }
                }catch{
                    print("error")
                }
                do {
                    print(response)
                    let errorCode = try JSONDecoder().decode(sotkeMessage.self, from: response.data!)
                    if errorCode.success == true {
                        completion(nil,true,nil,errorCode,nil)
                    }else {
                        completion(nil,true,nil,errorCode,nil)
                    }
                }catch {
                    print("error2")
                }
            }
        }
    }
    
    class func getTaxes(completion: @escaping(_ error: Error?,_ success: Bool,_ cart: texs?)-> Void){
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        let url = URLs.getOrderTaxes
        print(url)
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(texs.self, from: response.data!)
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

