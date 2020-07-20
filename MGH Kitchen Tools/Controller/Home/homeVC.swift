//
//  homeVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class homeVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var pageControlBanner: UIPageControl!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var flashSellCollecetion: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var searchTF: textFieldView!
    @IBOutlet weak var bestSelingHight: NSLayoutConstraint!
    
    var timer : Timer?
    var currentIndex = 0
    var slider = [slidersData]()
    var products = [productsDataArray]()
    var categorie = [dataCategoriesArray]()
    var hotDeal = [productsDataArray]()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        scrollview.refreshControl = refreshControl
        
        setUpNavColore(false, "")
        setUpNav(logo: true,  cart: true)
        startTimer()
        
        giftsGet()
        self.searchTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handelApiBanner()
        handelApiflashSale()
        handelApiCategory()
        handelApiBestSealing()
        refesHcart()
    }
    
    @objc func refresh(sender:AnyObject) {
        handelApiBanner()
        handelApiflashSale()
        handelApiCategory()
        handelApiBestSealing()
        refreshControl.endRefreshing()
    }
    
    func giftsGet() {
        loaderHelper()
        giftsApi.giftslApi{ (error,success,giftsArry) in
            if let giftsArry = giftsArry{
                if giftsArry.success == true {
                    if helperAuth.getAPIToken() == nil {
                        //                        let vc = loginVC(nibName: "loginVC", bundle: nil)
                        //                        let navigationController = UINavigationController(rootViewController: vc)
                        //                        navigationController.modalPresentationStyle = .fullScreen
                        //                        self.present(navigationController, animated: true, completion: nil)
                    }else {
//                        let vc = giftsVC(nibName: "giftsVC", bundle: nil)
//                        vc.modalPresentationStyle = .fullScreen
//
//                        self.present(vc,animated: true)
                        let vc = giftsVC(nibName: "giftsVC", bundle: nil)
                        let navigationController = UINavigationController(rootViewController: vc)
                        navigationController.modalPresentationStyle = .overFullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                }else{
                    
                }
                
                self.stopAnimating()
            }
            self.startAnimating()
        }
    }
    
    
    
    
    func handelApiCategory() {
        self.categoryCollectionView.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        loaderHelper()
        homeApi.categorieApi(page: 1){ (error,success,categorie) in
            if let categorie = categorie{
                self.categorie = categorie.data?.data ?? []
                print(categorie)
                self.categoryCollectionView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func handelApiBestSealing() {
        self.bestSellingCollectionView.register(UINib.init(nibName: "allProductViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bestSellingCollectionView.delegate = self
        bestSellingCollectionView.dataSource = self
        
        loaderHelper()
        homeApi.productsApi(url: URLs.bestSelling, pageName: 1,category_id: 0,name: ""){ (error,success,products) in
            if let products = products{
                self.products = products.data?.data ?? []
                print(products)
                self.bestSellingCollectionView.reloadData()
                self.bestSelingHight.constant = CGFloat(self.products.count * 198)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func handelApiflashSale() {
        self.flashSellCollecetion.register(UINib.init(nibName: "flashSaleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        flashSellCollecetion.delegate = self
        flashSellCollecetion.dataSource = self
        
        loaderHelper()
        homeApi.productsApi(url: URLs.hotDeal, pageName: 1,category_id: 0,name: ""){ (error,success,hotDeal) in
            if let hotDeal = hotDeal{
                self.hotDeal = hotDeal.data?.data ?? []
                print(hotDeal)
                self.flashSellCollecetion.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func handelApiBanner() {
        self.bannerCollectionView.register(UINib.init(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        homeApi.sliderApi{ (error,success,slider) in
            if let slider = slider{
                self.slider = slider.data ?? []
                print(slider)
                self.pageControlBanner.numberOfPages = self.slider.count
                self.pageControlBanner.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        if currentIndex < 5 {//slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlBanner.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControlBanner.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    @IBAction func bestSealingSeeAllBtn(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.url = URLs.bestSelling
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func catSeeAllBtn(_ sender: Any) {
        let vc = allCategoursVC(nibName: "allCategoursVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}


extension homeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == flashSellCollecetion {
            let vc = productDetailsVC(nibName: "productDetailsVC", bundle: nil)
            vc.singleItem = hotDeal[indexPath.row]
            vc.images = hotDeal[indexPath.row].productImages ?? []
            self.navigationController!.pushViewController(vc, animated: true)
        }else if collectionView == bestSellingCollectionView {
            let vc = productDetailsVC(nibName: "productDetailsVC", bundle: nil)
            vc.singleItem = products[indexPath.row]
            vc.images = products[indexPath.row].productImages ?? []
            self.navigationController!.pushViewController(vc, animated: true)
        }else if collectionView == categoryCollectionView {
            let vc = allProductVC(nibName: "allProductVC", bundle: nil)
            vc.singleItme = categorie[indexPath.row]
            vc.url = URLs.searchProduct
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return slider.count
        }else if collectionView == flashSellCollecetion {
            return hotDeal.count
        }else if collectionView == bestSellingCollectionView{
            return products.count
        }else{
            return categorie.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell {
                cell.configureCell(images: slider[indexPath.row])
                return cell
            }else {
                return bannerCell()
            }
        }else if collectionView == flashSellCollecetion {
            if let cell = flashSellCollecetion.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? flashSaleCell {
                cell.configureCell(products: hotDeal[indexPath.row])
                return cell
            }else {
                return flashSaleCell()
            }
        }else if collectionView == bestSellingCollectionView {
            if let cell = bestSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
                cell.configureCell(products: products[indexPath.row])
                return cell
            }else {
                return allProductViewCell()
            }
        }else {
            if let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell {
                cell.configureCell(images: categorie[indexPath.row])
                return cell
            }else {
                return CategoryCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == bannerCollectionView {
            return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
        }else if collectionView == flashSellCollecetion{
            return CGSize(width: flashSellCollecetion.frame.size.width, height: flashSellCollecetion.frame.size.height - 10)
        }else if collectionView == bestSellingCollectionView{
            return CGSize(width: bestSellingCollectionView.frame.size.width, height: 198)
        }else {
            return CGSize(width: categoryCollectionView.frame.size.width / 1.6, height: categoryCollectionView.frame.size.height - 10)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView{
            currentIndex = Int(scrollView.contentOffset.x / bannerCollectionView.frame.size.width)
            pageControlBanner.currentPage = currentIndex
        }
    }
    
    
}

extension homeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        
        textField.resignFirstResponder()
        performAction()
        return true
    }

    func performAction() {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.name = searchTF.text ?? ""
        self.navigationController!.pushViewController(vc, animated: true)
    }
}


extension homeVC: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
       print("SideMenu Disappearing! (animated: \(animated))")
        
        
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
//        handelApiBanner()
//        handelApiflashSale()
//        handelApiCategory()
//        handelApiBestSealing()
//        refesHcart()
    }
}
