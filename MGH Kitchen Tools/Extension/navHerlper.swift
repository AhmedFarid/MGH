//
//  navHerlper.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import UIKit
import SideMenu

extension UIViewController {
    
    func setUpNav(logo: Bool = false ,menu: Bool = false, cart: Bool = false) {
        switch logo {
        case true:
            let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            nvImageTitle.contentMode = .scaleAspectFit
            let imageName = UIImage(named: "MGH Logo copy-1")
            nvImageTitle.image = imageName
            navigationItem.titleView = nvImageTitle
        default:
            print("no")
        }
        switch menu {
        case true:
            let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(sideMenu))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
        default:
            print("no")
        }
        switch cart {
        case true:
            refesHcart()
        default:
            print("no")
        }
    }
    
    func refesHcart() {
           let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "BASKET"), style: .done, target: self, action: #selector(self.showCart))
           self.navigationItem.rightBarButtonItem = rightBarButtonItem
           homeApi.productsApi(url: URLs.carts, pageName: 1,category_id: 0,name: ""){ (error,success,products) in
               if products?.success == true {
                if products?.data?.data?.count == 0 {
                    let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "BASKET"), style: .done, target: self, action: #selector(self.showCart))
                    self.navigationItem.rightBarButtonItem = rightBarButtonItem
                }else {
                   self.addBadge(count: products?.data?.data?.count ?? 0)
                }
               }else {
                    let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "BASKET"), style: .done, target: self, action: #selector(self.showCart))
                    self.navigationItem.rightBarButtonItem = rightBarButtonItem
               }
           }
       }
    
    
    func setUpNavColore(_ isTranslucent: Bool,_ title: String){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        self.navigationItem.title = title
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0.5019607843, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc func sideMenu() {
        let menu = UIStoryboard(name: "sideMenu", bundle: nil).instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = view.frame.size.width - 50
        menu.statusBarEndAlpha = 0
        present(menu, animated: true, completion: nil)
    }
    
    @objc func showCart() {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func addBadge(count: Int) {
        let bagButton = BadgeButton()
        bagButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        bagButton.tintColor = UIColor.white
        bagButton.setImage(UIImage(named: "BASKET"), for: .normal)
        bagButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 5)
        print("cart Count \(count)")
        bagButton.badge = "\(count)"
        bagButton.addTarget(self, action: #selector(self.showCart), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagButton)
    }
}

extension AppDelegate {
    func hideBackButton() {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: -5), for:UIBarMetrics.default)
    }
    
}

extension  SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
//        setUpNavColore(true,"")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

