//
//  orderVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class orderVC: UIViewController {
    
    @IBOutlet weak var textCOngr: UILabel!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var orderText: UILabel!
    var orderMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true, "")
        let message = NSLocalizedString("Thanks For Your Order", comment: "profuct list lang")
        orderText.text = message
        text.text = orderMessage
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textCOngr.layer.cornerRadius = 8
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            self.textCOngr.text = "مبروك!"
        }
        
    }
    
    //helperAuth.restartApp()
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
        helperAuth.restartApp()
        
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        helperAuth.restartApp()
        
    }
    
}
