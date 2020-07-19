//
//  myOrdersVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class myOrdersVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var myOrdersCollectionVIew: UICollectionView!
    
    var products = [myOrdersData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, "")
        setUpNav(logo: true,  cart: true)
        handelApiflashSale()
       
    }
    
    @objc func handelApiflashSale() {
        self.myOrdersCollectionVIew.register(UINib.init(nibName: "myOrdersCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        myOrdersCollectionVIew.delegate = self
        myOrdersCollectionVIew.dataSource = self
        loaderHelper()
        myOrdersApi.myOrderDetealisApi{ (error,success,products) in
            if let products = products{
                self.products = products.data ?? []
                print(products)
                self.myOrdersCollectionVIew.reloadData()
                self.stopAnimating()
            }
        }
    }


    
}

extension myOrdersVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = myOrderDitalsVC(nibName: "myOrderDitalsVC", bundle: nil)
        vc.singelItem = products[indexPath.row]
        vc.products = products[indexPath.row].orderDetails ?? []
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = myOrdersCollectionVIew.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? myOrdersCell {
            let cartIndex = products[indexPath.row]
            cell.configureCell(products: cartIndex)
            return cell
        }else {
            return myOrdersCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: myOrdersCollectionVIew.frame.size.width, height: 150)
        
    }
    
    
    
}
