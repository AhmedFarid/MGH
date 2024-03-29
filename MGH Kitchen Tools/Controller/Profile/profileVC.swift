//
//  profileVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class profileVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var fullName: textFieldView!
    @IBOutlet weak var segmentProfile: UISegmentedControl!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var edit: buttonView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpNavColore(false, "")
        setUpNav(logo: true,  cart: true)
        
    }
    
    func setUpData() {
        loaderHelper()
        profileApi.getProfileApi { (error, success, profile) in
            if success {
                self.emailTF.text = profile?.data?.email
                self.phoneTF.text = profile?.data?.phone
                self.fullName.text = profile?.data?.fullName
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    
    @IBAction func editBtn(_ sender: Any) {
        switch segmentProfile.selectedSegmentIndex
        {
        case 0:
            loaderHelper()
            profileApi.editProfielApi(full_name: fullName.text ?? "", email: emailTF.text ?? "", phone: phoneTF.text ?? "") { (error, success, message) in
                if success {
                    self.showAlert(title: "Edit Profile", message: "Success Eidt Profile")
                    self.setUpData()
                    self.stopAnimating()
                }
                self.stopAnimating()
            }
        case 1:
            loaderHelper()
            profileApi.changePasswordApi(password: phoneTF.text ?? "", password_confirmation: emailTF.text ?? "", old_password: fullName.text ?? "") { (error, success, message) in
                if success {
                    if message?.success == true {
                        self.showAlert(title: "Change Password", message: "Password Eidt Success")
                        self.stopAnimating()
                        self.fullName.text = ""
                        self.phoneTF.text = ""
                        self.emailTF.text = ""
                    }else {
                        self.showAlert(title: "Change Password", message: "Password Eidt Faild")
                        self.stopAnimating()
                        self.fullName.text = ""
                        self.phoneTF.text = ""
                        self.emailTF.text = ""
                    }
                }
                self.stopAnimating()
            }
        default:
            break;
        }
        
    }
    
    @IBAction func segemtProfileBtm(_ sender: Any) {
        switch segmentProfile.selectedSegmentIndex
        {
        case 0:
            fullName.text = ""
            phoneTF.text = ""
            emailTF.text = ""
            
            fullNameLabel.text = NSLocalizedString("Full Name", comment: "profuct list lang")
            phoneLabel.text = NSLocalizedString("Phone", comment: "profuct list lang")
            emailLabel.text = NSLocalizedString("Email", comment: "profuct list lang")
            
            fullName.placeholder = NSLocalizedString("Full Name", comment: "profuct list lang")
            phoneTF.placeholder = NSLocalizedString("Phone", comment: "profuct list lang")
            emailTF.placeholder = NSLocalizedString("Email", comment: "profuct list lang")
            
            fullName.isSecureTextEntry = false
            phoneTF.isSecureTextEntry = false
            emailTF.isSecureTextEntry = false
            
            fullName.keyboardType = .default
            phoneTF.keyboardType = .phonePad
            emailTF.keyboardType = .emailAddress
            
            setUpData()
        case 1:
            fullNameLabel.text = NSLocalizedString("Old Pssword", comment: "profuct list lang")
            phoneLabel.text = NSLocalizedString("New Password", comment: "profuct list lang")
            emailLabel.text = NSLocalizedString("Password Confirmation", comment: "profuct list lang")
            
            fullName.placeholder = NSLocalizedString("Old Pssword", comment: "profuct list lang")
            phoneTF.placeholder = NSLocalizedString("New Password", comment: "profuct list lang")
            emailTF.placeholder = NSLocalizedString("Password Confirmation", comment: "profuct list lang")
            
            fullName.isSecureTextEntry = true
            phoneTF.isSecureTextEntry = true
            emailTF.isSecureTextEntry = true
            
            fullName.text = ""
            phoneTF.text = ""
            emailTF.text = ""
            
            fullName.keyboardType = .default
            phoneTF.keyboardType = .default
            emailTF.keyboardType = .default
        default:
            break;
        }
    }
    
}
