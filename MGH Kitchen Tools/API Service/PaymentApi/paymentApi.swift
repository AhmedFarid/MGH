//
//  paymentApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class paymentApi: NSObject {
    
    class func getPaymentApi(delivery_type:String,city_id: String,gift_id: String,code:String,customer_name: String,customer_phone: String,customer_city: String,customer_region: String,customer_street: String,customer_home_number: String,customer_floor_number: String,customer_address: String,payment_method: String,completion: @escaping(_ error: Error?,_ success: Bool,_ product: payment?)-> Void){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
        
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
        
        
        let url = URLs.paymentMob
        print(headers)
        print(url)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let product = try JSONDecoder().decode(payment.self, from: response.data!)
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
}

