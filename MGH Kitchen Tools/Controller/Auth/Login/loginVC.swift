//
//  loginVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class loginVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(true, "")
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 37"), style: .done, target: self, action: #selector(closeSignIn))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        let response = Validation.shared.validate(values:
            (ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.login(email: email.text ?? "", password: password.text ?? ""){ (error, success,Register,statusCode) in
                if success {
                    if statusCode == 200 {
                        self.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "Login", message: "email or password is incorrect")
                    }
                    
                }else {
                    self.showAlert(title: "Login", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "Login", message: message.localized())
        }
    }
    
    
    @objc func closeSignIn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupBTN(_ sender: Any) {
        let vc = SignupVC(nibName: "SignupVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgetPasswordBTNAction(_ sender: Any) {
        let vc = forgetPasswordVC(nibName: "forgetPasswordVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
