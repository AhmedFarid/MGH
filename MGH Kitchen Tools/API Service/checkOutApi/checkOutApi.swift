//
//  checkOutApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class checkOutApi: NSObject {
    
    class func makeOrderApi(delivery_type:String,city_id: String,gift_id: String,code:String,customer_name: String,customer_phone: String,customer_city: String,customer_region: String,customer_street: String,customer_home_number: String,customer_floor_number: String,customer_address: String,payment_method: String,completion: @escaping(_ error: Error?,_ success: Bool,_ fav: Messages?)-> Void){
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.makeOrder
        
        let parametars = [
            "customer_name": customer_name,
            "customer_phone": customer_phone,
            "customer_city": customer_city,
            "customer_region": customer_region,
            "customer_street": customer_street,
            "customer_home_number": customer_home_number,
            "customer_floor_number": customer_floor_number,
            "customer_address": customer_address,
            "payment_method": payment_method,
            "code": code,
            "gift_id": gift_id,
            "city_id": city_id,
            "delivery_type": delivery_type
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
        
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let addFov = try JSONDecoder().decode(Messages.self, from: response.data!)
                    if addFov.success == true {
                        completion(nil,true,addFov)
                    }else {
                        completion(nil,true,addFov)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func getPromocode(code: String,completion: @escaping(_ error: Error?,_ success: Bool,_ fav: promCodeSucces?,_ errorCode: promCodeError?)-> Void){
        
        guard let user_token = helperAuth.getAPIToken() else {
            completion(nil, false,nil,nil)
            return
        }
        
        let parametars = [
            "code": code
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)",
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
        let url = URLs.getPromocodeDiscount
        
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let addFov = try JSONDecoder().decode(promCodeSucces.self, from: response.data!)
                    if addFov.success == true {
                        completion(nil,true,addFov,nil)
                    }else {
                        completion(nil,true,addFov,nil)
                    }
                }catch{
                    print("error")
                }
                do {
                    print(response)
                    let errorCode = try JSONDecoder().decode(promCodeError.self, from: response.data!)
                    if errorCode.success == true {
                        completion(nil,true,nil,errorCode)
                    }else {
                        completion(nil,true,nil,errorCode)
                    }
                }catch {
                    print("error2")
                }
            }
        }
    }
    
    class func getDeliveries(completion: @escaping(_ error: Error?,_ success: Bool,_ cart: deliveries?)-> Void){
        
        let url = URLs.deliveries
        print(url)
        let headers: HTTPHeaders = [
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(deliveries.self, from: response.data!)
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


