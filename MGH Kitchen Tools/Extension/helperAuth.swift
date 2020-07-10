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
            let navigationController = UINavigationController(rootViewController: homeVC())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }else {
            let navigationController = UINavigationController(rootViewController: homeVC())
            window.rootViewController = navigationController
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
