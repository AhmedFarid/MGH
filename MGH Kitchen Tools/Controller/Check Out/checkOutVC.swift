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
    
    var delviers = [deliveriesData]()
    var x = [deliveryPrices]()
    
    @IBOutlet weak var promoCodeTF: textFieldView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var fullNameTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var cityTF: textFieldView!
    @IBOutlet weak var regionTF: textFieldView!
    @IBOutlet weak var streetTF: textFieldView!
    @IBOutlet weak var homeNumberTF: textFieldView!
    @IBOutlet weak var floorNumTF: textFieldView!
    @IBOutlet weak var delviryType: textFieldView!
    @IBOutlet weak var addressTF: textFieldView!
    
    var totlaPrice = 0
    var countCart = 0
    var curancy = ""
    var promo = 0
    var delveryTotal = 0
    var promoText = ""
    var cityId = 0
    var slow = 0
    var fast = 0
    var products = [productsDataArray]()
    var type = ""
    var delvertyTypes = ""
    
    let cityPicker = UIPickerView()
    let delviryTypePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)
        cityTF.isEnabled = false
        delviryType.isEnabled = false
        totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy)"
        cityPikerFunc()
    }
    
    func cityPikerFunc() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityTF.inputView = cityPicker
        loaderHelper()
        checkOutApi.getDeliveries{ (error,success,delviers) in
            if let delviers = delviers{
                self.delviers = delviers.data ?? []
                print(delviers)
                self.cityTF.isEnabled = true
                self.cityPicker.reloadAllComponents()
                self.stopAnimating()
            }
        }
    }
    
    func delviryTypePikerFunc() {
        delviryTypePicker.delegate = self
        delviryTypePicker.dataSource = self
        delviryType.inputView = delviryTypePicker
        self.delviryType.isEnabled = true
        self.delviryTypePicker.reloadAllComponents()
    }
    
    
    func promoCodeCheck() {
        loaderHelper()
        checkOutApi.getPromocode(code: promoCodeTF.text ?? "") { (error, success, message,errorCode) in
            if success {
                if message?.success == true {
                    self.showAlert(title: "Promo Code", message: "You have Discount \(message?.data?.discount ?? 0) \(self.curancy)")
                    self.promo = message?.data?.discount ?? 0
                    if self.delveryTotal == 0 {
                        self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \nYou have promo \(self.promo) \(self.curancy) Total Cost With Promo \(self.totlaPrice - self.promo + self.delveryTotal)"
                    }else {
                        self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \n \(self.delvertyTypes) Delivery fees \(self.delveryTotal) \nYou have promo \(self.promo) \(self.curancy) Total Cost With Promo \(self.totlaPrice - self.promo + self.delveryTotal)"
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
        
        let vc = checkoutDetiealsVC(nibName: "checkoutDetiealsVC", bundle: nil)
        vc.products = products
        vc.address = addres
        vc.type = totalPrice.text ?? ""
        vc.floorNumber = floorNum
        vc.homeNumber = appartNum
        vc.street = streetNam
        vc.region = region
        vc.cityId = "\(cityId)"
        vc.phone = phones
        vc.fullName = name
        vc.promoCode = promoCodeTF.text ?? ""
        vc.giftId = ""
        vc.delivery_type = delvertyTypes
        vc.cityName = citys
        self.navigationController!.pushViewController(vc, animated: true)
        

    }
    
    
    @IBAction func checkOutBtnAction(_ sender: Any) {
        creatOrder()
    }
    
    @IBAction func promoBTNAction(_ sender: Any) {
        promoCodeCheck()
    }
}


extension checkOutVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPicker {
            return delviers.count
        }else {
            return x.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPicker {
            return delviers[row].city?.name
        }else {
            return "\(x[row].vlaue ?? "") \(x[row].price ?? 0) \(curancy)"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPicker {
            x = []
            cityTF.text = delviers[row].city?.name
            cityId = delviers[row].city?.id ?? 0
            x.append(deliveryPrices(price: delviers[row].fastPrice ?? 0, vlaue: "Fast Price"))
            x.append(deliveryPrices(price: delviers[row].slowPrice ?? 0, vlaue: "Slow Price"))
            print(x)
            delviryType.text = ""
            delviryTypePikerFunc()
        }else {
            delviryType.text = "\(x[row].vlaue ?? "") \(x[row].price ?? 0) \(curancy)"
            self.delveryTotal = x[row].price ?? 0
            self.delvertyTypes = x[row].vlaue ?? ""
            if self.promo == 0 {
                self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \n \(x[row].vlaue ?? "") Delivery fees \(self.delveryTotal)"
            }else {
                self.totalPrice.text = "\(self.countCart) Item / Total Cost \(self.totlaPrice) \(self.curancy) \n \(x[row].vlaue ?? "") Delivery fees \(self.delveryTotal) \nYou have promo \(self.promo) \(self.curancy) Total Cost With Promo \(self.totlaPrice - self.promo + self.delveryTotal)"
            }
            
        }
    }
}
