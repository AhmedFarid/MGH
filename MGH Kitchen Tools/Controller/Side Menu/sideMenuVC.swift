//
//  sideMenuVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu

class sideMenuVC: UIViewController {
    
    @IBOutlet weak var loginOrSignupBtn: buttonView!
    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true, "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpAuthBTN()
    }
    
    func setUpAuthBTN() {
        if helperAuth.getAPIToken() == nil {
            loginOrSignupBtn.isHidden = false
            logoutBtn.isHidden = true
        }else {
            loginOrSignupBtn.isHidden = true
            logoutBtn.isHidden = false
        }
    }
    @IBAction func profileBtn(_ sender: Any) {
        let vc = profileVC(nibName: "profileVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func contactUs(_ sender: Any) {
        let vc = contactUsVC(nibName: "contactUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func aboutUs(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func newOffers(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.url = URLs.bestSelling
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func allProducts(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.url = URLs.searchProduct
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func shopNow(_ sender: Any) {
        let vc = allCategoursVC(nibName: "allCategoursVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func promoCode(_ sender: Any) {
    }
    
    @IBAction func myWishListBTn(_ sender: Any) {
        let vc = allProductVC(nibName: "allProductVC", bundle: nil)
        vc.url = URLs.favoirtes
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func myOrdersBtn(_ sender: Any) {
        let vc = myOrdersVC(nibName: "myOrdersVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func cartBtn(_ sender: Any) {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func homeBtn(_ sender: Any) {
        let vc = homeVC(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginOrSignupBtnAction(_ sender: Any) {
        let vc = loginVC(nibName: "loginVC", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        helperAuth.dleteAPIToken()
    }
}


