//
//  allProductVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class allProductVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var searchTF: textFieldView!
    @IBOutlet weak var allProductCollectionView: UICollectionView!
    
    var singleItme: dataCategoriesArray?
    var products = [productsDataArray]()
    var name = ""
    var url = ""
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: true)
        handelApiflashSale(name: name)
        searchTF.delegate = self
    }
    
    func SetupSearch() {
        if url == URLs.favoirtes {
            searchTF.isHidden = true
        }else {
            searchTF.isHidden = false
        }
    }
    
    @objc func handelApiflashSale(name: String) {
        self.allProductCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        guard !isLoading else { return }
        isLoading = true
        loaderHelper()
        homeApi.productsApi(url: url, pageName: 1,category_id: singleItme?.id ?? 0,name: name){ (error,success,products) in
            self.isLoading = false
            if let products = products{
                self.products = products.data?.data ?? []
                print(products)
                self.allProductCollectionView.reloadData()
                self.current_page = 1
                self.last_page = products.data?.meta?.lastPage ?? 0
                self.stopAnimating()
            }
        }
    }
    
    @objc func loadMore(name: String) {
        self.allProductCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        allProductCollectionView.delegate = self
        allProductCollectionView.dataSource = self
        guard !isLoading else {return}
        guard current_page < last_page else {return}
        isLoading = true
        homeApi.productsApi(url: url, pageName: current_page+1,category_id: singleItme?.id ?? 0,name: name){ (error,success,products) in
            self.isLoading = false
            if let products = products{
                self.products.append(contentsOf: products.data?.data ?? [])
                print(products)
                self.allProductCollectionView.reloadData()
                self.current_page += 1
                self.last_page = products.data?.meta?.lastPage ?? 0
                self.stopAnimating()
            }
        }
    }
}


extension allProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
        if let cell = allProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
            cell.configureCell(products: products[indexPath.row])
            return cell
        }else {
            return allProductViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        return CGSize(width: allProductCollectionView.frame.size.width, height: 185)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = self.products.count
        if indexPath.row ==  count-1 {
            self.loadMore(name: name)
        }
    }
    
}


extension allProductVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        handelApiflashSale(name: searchTF.text ?? "")
    }
}
