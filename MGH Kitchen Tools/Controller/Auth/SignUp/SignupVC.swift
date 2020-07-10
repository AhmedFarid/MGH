//
//  SignupVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SignupVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var fullName: textFieldView!
    @IBOutlet weak var phone: textFieldView!
    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func signUpBTNAction(_ sender: Any) {
        let response = Validation.shared.validate(values:
            (ValidationType.alphabeticString, fullName.text ?? "")
            ,(ValidationType.phoneNo, phone.text ?? "")
            ,(ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.register(full_name: fullName.text ?? "", email: email.text ?? "", phone: phone.text ?? "", password: password.text ?? "", password_confirmation: password.text ?? ""){ (error, success, apiSuccess,Register,statusCode) in
                if success {
                    if statusCode == 200 {
                            self.stopAnimating()
                            self.dismiss(animated: true, completion: nil)
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "SignUp", message: "email or phone are used")
                    }
                    
                }else {
                    self.showAlert(title: "SignUp", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "SignUp", message: message.localized())
        }
    }
}
