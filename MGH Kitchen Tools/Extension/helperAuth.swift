//
//  helperAuth.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import UIKit

class helperAuth: NSObject {
    
    class func restartApp(){
    guard let window = UIApplication.shared.keyWindow else {return}
    if getAPIToken() == nil {
       let tabBarController = UITabBarController()
        let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
        let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
        let categorusTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
        let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
        let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)
        
        homeTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Home", comment: "profuct list lang"), image: UIImage(named: "Group 397"), selectedImage: UIImage(named: "Group 398"))
        newOffersTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("New Offers", comment: "profuct list lang"),image:UIImage(named: "Group 393") ,selectedImage: UIImage(named: "Group 394"))
        categorusTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Categories", comment: "profuct list lang"),image: UIImage(named: "Group 395"),selectedImage: UIImage(named: "Group 396"))
        cartTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Cart", comment: "profuct list lang"),image:UIImage(named: "Group 388") ,selectedImage: UIImage(named: "Group 390"))
        myAcoutnTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("My Account", comment: "profuct list lang"),image:UIImage(named: "Group 392") ,selectedImage: UIImage(named: "Group 391"))
        let controllers = [homeTabVC,categorusTabVC,newOffersTabVC,cartTabVC,myAcoutnTabVC].map {
            UINavigationController(rootViewController: $0)
            
        }
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9882352941, green: 0.568627451, blue: 0.2274509804, alpha: 1)
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.4784313725, green: 0.8039215686, blue: 0.8392156863, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
        tabBarController.viewControllers = controllers
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 10)!], for: .selected)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }else {
        let tabBarController = UITabBarController()
              let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
              let newOffersTabVC = newOffersVC(nibName:"newOffersVC",bundle: nil)
              let categorusTabVC = allCategoursVC(nibName:"allCategoursVC",bundle: nil)
              let cartTabVC = cartVC(nibName:"cartVC",bundle: nil)
              let myAcoutnTabVC = myAccountVC(nibName: "myAccountVC",bundle: nil)
              
              homeTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Home", comment: "profuct list lang"), image: UIImage(named: "Group 397"), selectedImage: UIImage(named: "Group 398"))
              newOffersTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("New Offers", comment: "profuct list lang"),image:UIImage(named: "Group 393") ,selectedImage: UIImage(named: "Group 394"))
              categorusTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Categories", comment: "profuct list lang"),image: UIImage(named: "Group 395"),selectedImage: UIImage(named: "Group 396"))
              cartTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Cart", comment: "profuct list lang"),image:UIImage(named: "Group 388") ,selectedImage: UIImage(named: "Group 390"))
              myAcoutnTabVC.tabBarItem = UITabBarItem(title: NSLocalizedString("My Account", comment: "profuct list lang"),image:UIImage(named: "Group 392") ,selectedImage: UIImage(named: "Group 391"))
              let controllers = [homeTabVC,categorusTabVC,newOffersTabVC,cartTabVC,myAcoutnTabVC].map {
                  UINavigationController(rootViewController: $0)
                  
              }
              tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9882352941, green: 0.568627451, blue: 0.2274509804, alpha: 1)
              tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.4784313725, green: 0.8039215686, blue: 0.8392156863, alpha: 1)
              tabBarController.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9844431281, green: 0.9844661355, blue: 0.9844536185, alpha: 1)
              tabBarController.viewControllers = controllers
              
              UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-Regular", size: 10)!], for: .normal)
              UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 10)!], for: .selected)

              window.rootViewController = tabBarController
              window.makeKeyAndVisible()
    }
    UIView.transition(with: window, duration: 0.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
}

    
    class func dleteAPIToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_token")
        def.synchronize()
        restartApp()
        
        
    }
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        
    }
    
    class func getAPIToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? String
    }
    
}
