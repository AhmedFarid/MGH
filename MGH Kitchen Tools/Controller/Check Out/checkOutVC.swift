//
//  checkOutVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkOutVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var promoCodeTF: textFieldView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var fullNameTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var cityTF: textFieldView!
    @IBOutlet weak var regionTF: textFieldView!
    @IBOutlet weak var streetTF: textFieldView!
    @IBOutlet weak var homeNumberTF: textFieldView!
    @IBOutlet weak var floorNumTF: textFieldView!
    @IBOutlet weak var addressTF: textFieldView!
    
    var totlaPrice = 0
    var countCart = 0
    var curancy = ""
    var promo = 0
    var delveryTotal = 0
    var promoText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: false)
        
        totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy)"
    }
    
    func promoCodeCheck() {
        loaderHelper()
        checkOutApi.getPromocode(code: promoCodeTF.text ?? "") { (error, success, message,errorCode) in
            if success {
                if message?.success == true {
                    self.showAlert(title: "Promo Code", message: "You have Discount \(message?.data?.discount ?? 0) \(self.curancy)")
                    self.promo = message?.data?.discount ?? 0
                    if self.delveryTotal == 0 {
                        self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \nYou have promo \(self.promo) \(self.curancy) Total Cost With Promo \(self.totlaPrice - self.promo)"
                    }else {
                        self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \n Delivery fees \(self.delveryTotal) \nYou have promo \(self.promo) \(self.curancy) Total Cost With Promo \(self.totlaPrice - self.promo)"
                    }
                    self.stopAnimating()
                }else {
                    print("xxx")
                }
                if errorCode?.success == false {
                    self.showAlert(title: "Promo Code", message: errorCode?.data?.code?.first ?? "")
                    self.promoCodeTF.text = ""
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Promo Code", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    
    func creatOrder() {
        
        guard let name = fullNameTF.text, !name.isEmpty else {
            let messages = NSLocalizedString("enter your Name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phoneTF.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let citys = cityTF.text, !citys.isEmpty else {
            let messages = NSLocalizedString("enter your city", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let region = regionTF.text, !region.isEmpty else {
            let messages = NSLocalizedString("enter your region", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let streetNam = streetTF.text, !streetNam.isEmpty else {
            let messages = NSLocalizedString("enter your street name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let appartNum = homeNumberTF.text, !appartNum.isEmpty else {
            let messages = NSLocalizedString("enter your home number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let floorNum = floorNumTF.text, !floorNum.isEmpty else {
            let messages = NSLocalizedString("enter your floor number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
             
        guard let addres = addressTF.text, !addres.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        loaderHelper()
        checkOutApi.makeOrderApi(code: promoCodeTF.text ?? "", customer_name: fullNameTF.text ?? "", customer_phone: phoneTF.text ?? "", customer_city: cityTF.text ?? "", customer_region: regionTF.text ?? "", customer_street: streetTF.text ?? "", customer_home_number: homeNumberTF.text ?? "", customer_floor_number: floorNumTF.text ?? "", customer_address: addressTF.text ?? "", payment_method: "0"){ (error, success, message) in
            if success {
                if message?.success == true {
                    self.stopAnimating()
                    let alert = UIAlertController(title: "Order", message: "Your Order Is Success", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                        let vc = homeVC(nibName: "homeVC", bundle: nil)
                        self.navigationController!.pushViewController(vc, animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.showAlert(title: "Oreder", message: message?.message ?? "")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Order", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    
    
    
    @IBAction func checkOutBtnAction(_ sender: Any) {
        creatOrder()
        
    }
    
    @IBAction func promoBTNAction(_ sender: Any) {
        promoCodeCheck()
    }
}
