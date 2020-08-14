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
    
    class func getPaymentApi(completion: @escaping(_ error: Error?,_ success: Bool,_ product: payment?)-> Void){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang,
            "Content-Type": "application/json"
        ]
        
        
        let url = URLs.paymentMob
        print(headers)
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

