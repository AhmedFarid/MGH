//
//  giftsApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class giftsApi: NSObject {
    
    class func giftslApi(completion: @escaping(_ error: Error?,_ success: Bool,_ product: gifts?)-> Void){
           
           let headers: HTTPHeaders = [
               "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
               "X-localization": URLs.mainLang,
               "Content-Type": "application/json"
           ]
        
        
           let url = URLs.gifts
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
                       let product = try JSONDecoder().decode(gifts.self, from: response.data!)
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

    class func getGift(gift_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ fav: Messages?)-> Void){
            
            guard let user_token = helperAuth.getAPIToken() else {
                completion(nil, false,nil)
                return
            }
            
            let url = URLs.getGift
            
            let parametars = [
                "gift_id": gift_id
                ] as [String : Any]
            
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
    }
