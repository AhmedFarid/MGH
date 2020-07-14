//
//  myOrderDitalsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

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
    
    var singelItem: myOrdersData?
    var products = [productsDataArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: true)
        setUpData()
    }
    
    func setUpData() {
        self.procutesCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        procutesCollectionView.delegate = self
        procutesCollectionView.dataSource = self
        
        orderIdLabel.text = "Order Id: \(singelItem?.id ?? 0)"
        orderQuntetyLabel.text = "Order Quantity: \(singelItem?.orderDetails?.count ?? 0)"
        orderTotalLabel.text = "Order Price: \(singelItem?.total ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
        orderDateLabel.text = singelItem?.createdAt
        
        orderStatus.text = singelItem?.status ?? ""
        paymetMethodLabel.text = singelItem?.paymentMethod ?? ""
        
        if singelItem?.paymentStatus == "0" {
            paymedtStatus.text = "Not Paid"
        }else {
            paymedtStatus.text = "Paid"
        }
        
        if singelItem?.promocodeValue == 0{
            promoCodeLabel.text = "No Promo Code"
            promoValus.text = "Promo Value: 0\(singelItem?.orderDetails?.first?.currency ?? "")"
        }else {
            promoCodeLabel.text = "Promo Code: \(singelItem?.promocode ?? "")"
            promoValus.text = "Promo Value: \(singelItem?.promocodeValue ?? 0) \(singelItem?.orderDetails?.first?.currency ?? "")"
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
        
        
        return CGSize(width: procutesCollectionView.frame.size.width, height: 185)
        
    }
}
