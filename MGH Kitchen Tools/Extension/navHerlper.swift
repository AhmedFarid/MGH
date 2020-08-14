//
//  navHerlper.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import UIKit
import SideMenu
import MOLH

extension UIViewController {
    
    func setUpNav(logo: Bool = false , cart: Bool = false) {
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
        switch cart {
        case true:
            refesHcart()
        default:
            print("no")
        }
    }
    
    func refesHcart() {
        homeApi.productsApi(url: URLs.carts, pageName: 1,category_id: 0,name: ""){ (error,success,products) in
            if products?.success == true {
                if products?.data?.data?.count == 0 {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let tabItem = tabItems[3]
                        tabItem.badgeValue = nil
                    }
                }else {
                    if let tabItems = self.tabBarController?.tabBar.items {
                        // In this case we want to modify the badge number of the third tab:
                        let tabItem = tabItems[3]
                        tabItem.badgeValue = "\(products?.data?.data?.count ?? 0)"
                    }
                    //self.addBadge(count: products?.data?.data?.count ?? 0)
                }
            }else {
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
    
    
}

extension AppDelegate {
    func hideBackButton() {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        BarButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: -5), for:UIBarMetrics.default)
    }
    
}


extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        }else {
            if textAlignment == .natural {
                self.textAlignment = .left
            }
        }
    }
}
