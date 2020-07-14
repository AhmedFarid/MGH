//
//  contactUsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class contactUsVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var FullnameTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var messageTF: textFieldView!
    @IBOutlet weak var emailTF: textFieldView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: true)

    }
    
    
    @IBAction func sendBtn(_ sender: Any) {
        loaderHelper()
        aboutUsApi.contactUsApi(name: FullnameTF.text ?? "", email: emailTF.text ?? "", phone: phoneTF.text ?? "", message: messageTF.text ?? "") { (error, success, messge) in
            if success {
                self.showAlert(title: "Contact Us", message: "send success")
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    

}
