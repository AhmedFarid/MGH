//
//  myOrderDitalsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class myOrderDitalsVC: UIViewController {
    
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderQuntetyLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var paymetMethodLabel: UILabel!
    @IBOutlet weak var paymedtStatus: UILabel!
    @IBOutlet weak var promoCodeLabel: UILabel!
    @IBOutlet weak var promoValus: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var procutesCollectionView: UICollectionView!
    @IBOutlet weak var hightConst: NSLayoutConstraint!
    @IBOutlet weak var deleveryType: UILabel!
    @IBOutlet weak var deleveryPrice: UILabel!
    
    var singelItem: myOrdersData?
    var products = [productsDataArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(false, "")
        setUpNav(logo: true,  cart: true)
        self.hightConst.constant = CGFloat(self.products.count * 210)
        setUpData()
    }
    
    
    
    func setUpData() {
        
        deleveryType.text = "\(NSLocalizedString("Delivery Type:", comment: "profuct list lang"))  \(singelItem?.deliveryType ?? "")"
        deleveryPrice.text = "\(NSLocalizedString("Delivery Price:", comment: "profuct list lang")) \(singelItem?.deliveryFees ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        if singelItem?.deliveryType == "fast"{
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                deleveryType.text = "توصيل سريع"
            }
        }else {
           if MOLHLanguage.currentAppleLanguage() == "ar" {
            deleveryType.text = "توصيل عادي"
            }
        }
        
        self.procutesCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        procutesCollectionView.delegate = self
        procutesCollectionView.dataSource = self
        
        orderIdLabel.text = "\(NSLocalizedString("Order Id:", comment: "profuct list lang")) \(singelItem?.id ?? 0)"
        orderQuntetyLabel.text = "\(NSLocalizedString("Order Quantity:", comment: "profuct list lang")) \(singelItem?.orderDetails?.count ?? 0)"
        orderTotalLabel.text = "\(NSLocalizedString("Order Price:", comment: "profuct list lang")) \(singelItem?.total ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        orderDateLabel.text = singelItem?.createdAt
        
        orderStatus.text = singelItem?.status ?? ""
        
        if singelItem?.status == "pendding"{
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "قيد الانتظار"
                   }
               }else if singelItem?.status == "inShipment" {
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "في الطريق"
                   }
               }else if singelItem?.status == "onDelivery" {
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "قيد التحضير"
                   }
               }else if singelItem?.status == "completed" {
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "تم التواصل"
                   }
               }else if singelItem?.status == "canceled" {
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "ألغيت"
                   }
               }else if singelItem?.status == "paymentDone" {
                   if MOLHLanguage.currentAppleLanguage() == "ar" {
                       orderStatus.text = "تم الدفع"
                   }
               }
        
        paymetMethodLabel.text = singelItem?.paymentMethod ?? ""
        
        if singelItem?.paymentMethod == "cacheOnDelivery"{
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                paymetMethodLabel.text = "الدفع عند الاستلام"
            }
        }else {
            if MOLHLanguage.currentAppleLanguage() == "ar" {
                paymetMethodLabel.text = "دفع ب الكرديت"
            }
        }
        
        
        if singelItem?.paymentStatus == "0" {
            paymedtStatus.text = NSLocalizedString("Not Paid", comment: "profuct list lang")
        }else {
            paymedtStatus.text = NSLocalizedString("Paid", comment: "profuct list lang")
        }
        
        if singelItem?.promocodeValue == 0{
            promoCodeLabel.text = NSLocalizedString("No Promo Code", comment: "profuct list lang")
            promoValus.text = "\(NSLocalizedString("Promo Value: 0", comment: "profuct list lang")) \(singelItem?.orderDetails?.first?.currency ?? "")"
        }else {
            promoCodeLabel.text = "\(NSLocalizedString("Promo Code:", comment: "profuct list lang")) \(singelItem?.promocode ?? "")"
            promoValus.text = "\(NSLocalizedString("Promo Value:", comment: "profuct list lang")) \(singelItem?.promocodeValue ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        }
        
        name.text = singelItem?.customerName ?? ""
        phone.text = singelItem?.customerPhone ?? ""
        addressLabel.text = singelItem?.customerAddress ?? ""
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension myOrderDitalsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = productDetailsVC(nibName: "productDetailsVC", bundle: nil)
        vc.singleItem = products[indexPath.row]
        vc.images = products[indexPath.row].productImages ?? []
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = procutesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
            cell.configureCell(products: products[indexPath.row])
            return cell
        }else {
            return allProductViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        return CGSize(width: procutesCollectionView.frame.size.width, height: 210)
        
    }
}
