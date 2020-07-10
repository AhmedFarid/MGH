//
//  homeApi.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class homeApi: NSObject {
    
    
    class func sliderApi(completion: @escaping(_ error: Error?,_ success: Bool,_ photos: sliders?)-> Void){
        
        
        let url = URLs.sliders
        print(url)
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let images = try JSONDecoder().decode(sliders.self, from: response.data!)
                    if images.success == true {
                        completion(nil,true,images)
                    }else {
                        completion(nil,true,images)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
    
    
    class func productsApi(url: String,pageName: Int,category_id: Int,name: String,completion: @escaping(_ error: Error?,_ success: Bool,_ product: products?)-> Void){
        print(url)
        let parameters = [
            "page": pageName,
            "name": name,
            "category_id": category_id
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(helperAuth.getAPIToken() ?? "")",
            "X-localization": URLs.mainLang
        ]
        
        print("ccc\(parameters)")
        print(headers)
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let product = try JSONDecoder().decode(products.self, from: response.data!)
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
    
    class func categorieApi(page: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ categorie: categories?)-> Void){
        
        let url = URLs.categories
        print(url)
        let parameters = [
            "page": page
        ]
        
        let headers: HTTPHeaders = [
            "X-localization": URLs.mainLang
        ]
        
        print(parameters)
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let categorie = try JSONDecoder().decode(categories.self, from: response.data!)
                    if categorie.success == true {
                        completion(nil,true,categorie)
                    }else {
                        completion(nil,true,categorie)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
        
    }
}
