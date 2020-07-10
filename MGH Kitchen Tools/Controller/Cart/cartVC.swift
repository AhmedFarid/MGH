//
//  cartVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class cartVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var checkOutBtn: buttonView!
    @IBOutlet weak var totalView: viewCosttom!
    
    var products = [productsDataArray]()
    var toalPrice = 0
    var curancy = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handelApiflashSale()
    }

    @objc func handelApiflashSale() {
        self.cartCollectionView.register(UINib.init(nibName: "cartCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        loaderHelper()
        homeApi.productsApi(url: URLs.carts, pageName: 1,category_id: 0,name: ""){ (error,success,products) in
            if let products = products{
                self.products = products.data?.data ?? []
                self.toalPrice = 0
                for i in self.products {
                    self.toalPrice = self.toalPrice + (i.productInCartTotal ?? 0)
                    self.curancy = i.currency ?? ""
                }
                self.cartPrice.text = "\(self.products.count) Item / Total Cost \(self.toalPrice) \(self.curancy)"
                print(products)
                if self.products.count == 0{
                    self.cartCollectionView.isHidden = true
                    self.totalView.isHidden = true
                    self.checkOutBtn.isHidden = true
                    self.cartCollectionView.reloadData()
                    self.stopAnimating()
                }
                self.cartCollectionView.reloadData()
                self.stopAnimating()
            }
        }
    }
    
    
    func cart(url: String,product_id: Int,qty: Int) {
        loaderHelper()
        cartApi.cartOption(url: url, product_id: "\(product_id)", qty: "\(qty)") { (error, success, message) in
            if success {
                if message?.success == true {
                    if url == URLs.addToCart {
                        self.handelApiflashSale()
                        self.showAlert(title: "Cart", message: "")
                    }else if url == URLs.removeFromCart {
                        self.handelApiflashSale()
                        self.showAlert(title: "Cart", message: "Removed From Cart")
                    }
                    self.handelApiflashSale()
                    self.stopAnimating()
                }else {
                    self.handelApiflashSale()
                    self.showAlert(title: "Cart", message: "")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func checkOutBtn(_ sender: Any) {
        let vc = checkOutVC(nibName: "checkOutVC", bundle: nil)
        vc.totlaPrice = toalPrice
        vc.curancy = curancy
        vc.countCart = products.count
        self.navigationController!.pushViewController(vc, animated: true)
    }
    

}


extension cartVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
        if let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? cartCollectionCell {
            let cartIndex = products[indexPath.row]
            cell.configureCell(products: cartIndex)
            
            if cartIndex.productInCartQty == 1{
                cell.mainBtn.isHidden = true
            }else {
                cell.mainBtn.isHidden = false
            }
            
            cell.add = {
                self.cart(url: URLs.addToCart, product_id: cartIndex.id ?? 0, qty: (cartIndex.productInCartQty ?? 0) + 1)
                
            }
            
            cell.min = {
                self.cart(url: URLs.addToCart, product_id: cartIndex.id ?? 0, qty: (cartIndex.productInCartQty ?? 0) - 1)
                
            }
            
            cell.deleteBtn = {
                self.cart(url: URLs.removeFromCart, product_id: cartIndex.id ?? 0, qty: (cartIndex.productInCartQty ?? 0) + 1)
                
            }
            return cell
        }else {
            return cartCollectionCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: cartCollectionView.frame.size.width, height: 178)
        
    }
    
    
    
}
