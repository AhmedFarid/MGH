//
//  subCategours.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/16/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class subCategours: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var singleCat: dataCategoriesArray?
    var categorie = [dataCategoriesArray]()
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handelApiCategory), for: .valueChanged)
        return refresher
    }()
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, singleCat?.name ?? "")
        categoryCollectionView.addSubview(refresher)
        handelApiCategory()
    }
    
    
    @objc func handelApiCategory() {
        self.categoryCollectionView.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
    }
    
}

extension subCategours: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.singleItmeSub = categorie[indexPath.row]
        vc.url = URLs.searchProduct
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categorie.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell {
            cell.configureCell(images: categorie[indexPath.row])
            return cell
        }else {
            return CategoryCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let screenWidth = categoryCollectionView.frame.width
        
        var width = (screenWidth - 10)/2
        
        width = width < 130 ? 160 : width
        
        return CGSize.init(width: width, height: 200)
        
        
    }
    
}
