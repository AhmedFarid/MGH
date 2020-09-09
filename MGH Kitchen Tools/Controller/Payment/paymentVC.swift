//
//  paymentVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

protocol paymentSceecss {
    func makeOrder(Success: Bool)
}

import UIKit
import WebKit

class paymentVC: UIViewController,WKNavigationDelegate, WKUIDelegate  {
    
    @IBOutlet weak var paymentWeb: WKWebView!
    
    var address = ""
    var type = ""
    var floorNumber = ""
    var homeNumber = ""
    var street = ""
    var region = ""
    var cityId = ""
    var phone = ""
    var fullName = ""
    var promoCode = ""
    var giftId = ""
    var delivery_type = ""
    var cityName = ""
    var payemtType = ""
    var deliveryTypes = ""
    
    var delegate: paymentSceecss?
    var currentURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getPaymentUrl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
        
         if #available(iOS 9.0, *)
           {
               let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
               let date = NSDate(timeIntervalSince1970: 0)

               WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
           }
           else
           {
               var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
               libraryPath += "/Cookies"

               do {
                   try FileManager.default.removeItem(atPath: libraryPath)
               } catch {
                   print("error")
               }
               URLCache.shared.removeAllCachedResponses()
           }
    }
    
    func getPaymentUrl() {
        if delivery_type == "Fast Price" {
            type = "fast"
        }else {
            type = "slow"
        }

        paymentApi.getPaymentApi(delivery_type: type,city_id: cityId,gift_id:giftId, code: promoCode, customer_name: fullName, customer_phone: phone, customer_city: cityName, customer_region: region, customer_street: street, customer_home_number: homeNumber, customer_floor_number: floorNumber, customer_address: address, payment_method: "payOnline") { (error, success, payment) in
            if success {
                if payment?.success == true {
                    print(payment?.data?.link ?? "")
                    self.paymentWeb.load(URLRequest(url: URL(string: payment?.data?.link ?? "")!))
                    self.paymentWeb.navigationDelegate = self
                    self.paymentWeb.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
                    
                }
            }
        }
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let newValue = change?[.newKey] {
            self.currentURL = "\(newValue)"
            print("url changed: \(currentURL)")
            if self.currentURL.contains("https://mgh4kt.com/en/customer/login") == true{
                self.paymentWeb.stopLoading()
                self.paymentWeb.isHidden = true
                delegate?.makeOrder(Success: true)
                self.dismiss(animated: true, completion: nil)
                
            }else if self.currentURL.contains("https://mgh4kt.com/customer/paymentFailed") == true{
                self.paymentWeb.stopLoading()
                self.paymentWeb.isHidden = true
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                let alert = UIAlertController(title: "Error!", message: "payment Failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action: UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.makeOrder(Success: false)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            print("url changed: \(newValue)")
        }
    }
    
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
        {
            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, cred)
        }
        else
        {
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
    
}

