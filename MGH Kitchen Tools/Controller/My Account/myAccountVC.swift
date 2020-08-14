//
//  myAccountVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MOLH

class myAccountVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var ordersBtn: UIButton!
    @IBOutlet weak var wichListBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var promoPtn: UIButton!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var secondeTitleLabel: UILabel!
    @IBOutlet weak var promoStack: UIStackView!
    @IBOutlet weak var wishLsitStack: UIStackView!
    @IBOutlet weak var ordersStack: UIStackView!
    @IBOutlet weak var lgoOutBtn: UIStackView!
    
    var promo = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)

        setUpView()
    }
    
    func setUpView() {
        if helperAuth.getAPIToken() == nil {
            self.ordersStack.isHidden = true
            self.wishLsitStack.isHidden = true
            self.profileLabel.text = NSLocalizedString("Login", comment: "profuct list lang")
            self.promoStack.isHidden = true
            self.lgoOutBtn.isHidden = true
            self.topTitleLabel.text = NSLocalizedString("Ahlan! Nice to meet you", comment: "profuct list lang")
            self.secondeTitleLabel.text = NSLocalizedString("The region's favourite online marketplace", comment: "profuct list lang")
        }else {
           self.ordersStack.isHidden = false
           self.wishLsitStack.isHidden = false
            self.profileLabel.text = NSLocalizedString("Profile", comment: "profuct list lang")
           self.promoStack.isHidden = false
            self.lgoOutBtn.isHidden = false
            
            loaderHelper()
            profileApi.getProfileApi { (error, success, profile) in
                if success {
                    self.topTitleLabel.text = "\(NSLocalizedString("Ahlan", comment: "profuct list lang")) \(profile?.data?.fullName ?? "")"
                    self.secondeTitleLabel.text = "\(profile?.data?.email ?? "")"
                    self.promo = profile?.data?.promocode ?? ""
                    self.stopAnimating()
                }
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func ordersBtn(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
            let vc = myOrdersVC(nibName: "myOrdersVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func wishListBtnAction(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
            let vc = allProductVC(nibName: "allProductVC", bundle: nil)
            vc.url = URLs.favoirtes
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func promoCodeAction(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
            let vc = promoFirndVC(nibName: "promoFirndVC", bundle: nil)
            vc.Promo = promo
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        if helperAuth.getAPIToken() == nil {
            let vc = loginVC(nibName: "loginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }else {
        let vc = profileVC(nibName: "profileVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func aboutUsBtnAction(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func contanctUsBtnAction(_ sender: Any) {
        let vc = contactUsVC(nibName: "contactUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func langUageBtn(_ sender: Any) {
        let selectLanguage = NSLocalizedString("Select Language", comment: "profuct list lang")
               let alert = UIAlertController(title: selectLanguage, message: "", preferredStyle: UIAlertController.Style.actionSheet)
                      alert.addAction(UIAlertAction(title: "English", style: .destructive, handler: { (action: UIAlertAction) in
                          MOLH.setLanguageTo("en")
                       URLs.mainLang = "en"
                          helperAuth.restartApp()
                      }))
                      alert.addAction(UIAlertAction(title: "عربى", style: .destructive, handler: { (action: UIAlertAction) in
                          MOLH.setLanguageTo("ar")
                       URLs.mainLang = "ar"
                          helperAuth.restartApp()
                      }))
                      alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
                      self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        helperAuth.dleteAPIToken()
        setUpView()
    }
}
