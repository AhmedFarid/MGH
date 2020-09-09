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
import MOLH

class homeVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var pageControlBanner: UIPageControl!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var flashSellCollecetion: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestSellingCollectionView: UICollectionView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var searchTF: textFieldView!
    @IBOutlet weak var bestSelingHight: NSLayoutConstraint!
    @IBOutlet weak var flashLb: UILabel!
    @IBOutlet weak var flashHight: NSLayoutConstraint!
    
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
        giftsApi.giftslApi{ (error,success,giftsArry) in
            if let giftsArry = giftsArry{
                if giftsArry.success == true {
                    if helperAuth.getAPIToken() == nil {
                      
                    }else {
//
                        let vc = giftsVC(nibName: "giftsVC", bundle: nil)
                        let navigationController = UINavigationController(rootViewController: vc)
                        navigationController.modalPresentationStyle = .overFullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                }else{
                    
                }
            }
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
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    self.categorie.reverse()
                    
                }
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
        homeApi.productsApi(url: URLs.bestSelling, pageName: 1, product_id: 0,category_id: "", subcategory_id: "",name: ""){ (error,success,products) in
            if let products = products{
                self.products = products.data?.data ?? []
                print(products)
                self.bestSellingCollectionView.reloadData()
                self.bestSelingHight.constant = CGFloat(self.products.count * 210)
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
         homeApi.productsApi(url: URLs.hotDeal, pageName: 1, product_id: 0,category_id: "", subcategory_id: "",name: ""){ (error,success,hotDeal) in
            if hotDeal?.success == true {
                if let hotDeal = hotDeal{
                    self.hotDeal = hotDeal.data?.data ?? []
                    print(hotDeal)
                    if self.hotDeal.count != 0 {
                        self.flashHight.constant = CGFloat(210)
                        self.flashLb.isHidden = false
                    }else {
                        self.flashHight.constant = CGFloat(1)
                        self.flashLb.isHidden = true
                    }
                    
                    if MOLHLanguage.currentAppleLanguage() == "ar"{
                        self.hotDeal.reverse()
                        
                    }
                    self.flashSellCollecetion.reloadData()
                    self.stopAnimating()
                }
            }else {
                self.stopAnimating()
            }
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
                self.bannerCollectionView.semanticContentAttribute = .forceLeftToRight
                self.pageControlBanner.numberOfPages = self.slider.count
                self.pageControlBanner.currentPage = 0
                self.startTimer()
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
    
    func cart(url: String,id: String) {
        loaderHelper()
        cartApi.cartOption(url: url, product_id: id, qty: "\(1)", color: "") { (error, success, message,errorStoke,x) in
            if success {
                if message?.success == true {
                    if url == URLs.addToCart {
                        self.handelApiflashSale()
                        self.handelApiBestSealing()
                        self.showAlert(title: "Cart", message: "Added To Cart")
                    }else if url == URLs.removeFromCart {
                        self.handelApiflashSale()
                        self.handelApiBestSealing()
                        self.showAlert(title: "Cart", message: "Removed From Cart")
                    }
                    self.stopAnimating()
                }else {
                    self.showAlert(title: "Cart", message: "Out Of Stock")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
            }
            
            if errorStoke?.success == false {
                self.showAlert(title: "stock", message: "Out Of Stock")
                self.stopAnimating()
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    
    func fav(url: String,id: String) {
        loaderHelper()
        favoriteApi.favoriteOption(url: url, product_id: id) { (error, success, message) in
            if success {
                if message?.success == true {
                    if url == URLs.addFavorite {
                        self.handelApiBestSealing()
                        self.showAlert(title: "Favorite", message: "Added To Favorite")
                    }else if url == URLs.removeFavorite {
                        self.handelApiBestSealing()
                        self.showAlert(title: "Favorite", message: "Remove From Favorite")
                    }
                    self.stopAnimating()
                }else {
                    self.showAlert(title: "Favorite", message: "")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Favorite", message: "Check your network")
                self.stopAnimating()
            }
        }
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
            if categorie[indexPath.row].subcategories?.count == 0 {
                let vc = allProductVC(nibName: "allProductVC", bundle: nil)
                vc.singleItme = categorie[indexPath.row]
                vc.url = URLs.searchProduct
                self.navigationController!.pushViewController(vc, animated: true)
                
            }else {
                let vc = subCategours(nibName: "subCategours", bundle: nil)
                vc.categorie = categorie[indexPath.row].subcategories ?? []
                self.navigationController!.pushViewController(vc, animated: true)
            }
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
                cell.add = {
                    if self.hotDeal[indexPath.row].productInCart == 1 {
                        self.cart(url: URLs.removeFromCart, id: "\(self.hotDeal[indexPath.row].id ?? 0)")
                        self.refesHcart()
                    }else if self.hotDeal[indexPath.row].productInCart == 0 {
                        self.cart(url: URLs.addToCart, id: "\(self.hotDeal[indexPath.row].id ?? 0)")
                        self.refesHcart()
                    }
                }
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
                
                return cell
            }else {
                return flashSaleCell()
            }
        }else if collectionView == bestSellingCollectionView {
            if let cell = bestSellingCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? allProductViewCell {
                cell.configureCell(products: products[indexPath.row])
                cell.addCart = {
                    if self.products[indexPath.row].productInCart == 1 {
                        self.cart(url: URLs.removeFromCart, id: "\(self.products[indexPath.row].id ?? 0)")
                        self.refesHcart()
                    }else if self.products[indexPath.row].productInCart == 0 {
                        self.cart(url: URLs.addToCart, id: "\(self.products[indexPath.row].id ?? 0)")
                        self.refesHcart()
                    }
                }
                
                cell.addFav = {
                    if self.products[indexPath.row].isProductFavoirte == 1 {
                        self.fav(url: URLs.removeFavorite, id: "\(self.products[indexPath.row].id ?? 0)")
                    }else if self.products[indexPath.row].isProductFavoirte == 0 {
                        self.fav(url: URLs.addFavorite,id: "\(self.products[indexPath.row].id ?? 0)")
                    }
                    
                }
                
                return cell
            }else {
                return allProductViewCell()
            }
        }else {
            if let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCell {
                cell.configureCell(images: categorie[indexPath.row])
                if MOLHLanguage.currentAppleLanguage() == "ar"{
                    collectionView.transform = CGAffineTransform(scaleX:-1,y: 1);
                    cell.transform = CGAffineTransform(scaleX:-1,y: 1);
                    
                }
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
            return CGSize(width: bestSellingCollectionView.frame.size.width, height: 210)
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
        vc.url = URLs.searchProduct
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


