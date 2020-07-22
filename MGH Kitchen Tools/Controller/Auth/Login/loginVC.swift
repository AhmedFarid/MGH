//
//  loginVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

class loginVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    @IBOutlet weak var signGooleBtn: GIDSignInButton!
    @IBOutlet weak var signWihtAppleBTN: UIButton!
    
    
    var googleSignIn = GIDSignIn.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(true, "")
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 37"), style: .done, target: self, action: #selector(closeSignIn))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        GIDSignIn.sharedInstance().signOut()
        setupViewAppleBTN()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance().signOut()
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
    
    func scailLogin(full_name: String,email: String,social_id: String) {
        loaderHelper()
        authApi.FBLogin(full_name: full_name, email: email, social_id: social_id){ (error, success,Register,statusCode) in
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
    }
    
    
    
    @IBAction func fbLoginBTN(_ sender: Any) {
        
        let fbdLoginManager: LoginManager = LoginManager()
        fbdLoginManager.logIn(permissions: ["email"], from: self){ (result,error) in
            if (error == nil) {
                let fbLoginResult: LoginManagerLoginResult = result!
                if fbLoginResult.grantedPermissions != nil {
                    if(fbLoginResult.grantedPermissions.contains("email")) {
                        self.GetFBUserData()
                        fbdLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogout(_ loginButoon: FBLoginButton!) {
        print("user Logout")
    }
    
    func GetFBUserData() {
        if((AccessToken.current) != nil) {
            GraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler:{(connection, result, error)-> Void in
                if (error == nil) {
                    let faceDic = result as! [String: AnyObject]
                    print(faceDic)
                    let email = faceDic["email"] as? String
                    print(email ?? "")
                    let id = faceDic["id"] as? String
                    print(id ?? "")
                    let fname = faceDic["first_name"] as? String
                    print(fname ?? "")
                    let lname = faceDic["last_name"] as? String
                    print(lname ?? "")
                    if id != "" {
                        
                        self.scailLogin(full_name: "\(fname ?? "") \(lname ?? "")", email: email ?? "\(id ?? "")@facebook.com", social_id: id ?? "")
                        
                    }
                }
            })
        }
    }
    
    //Googel Sign in
    @IBAction func googleACtion(_ sender: Any) {
        self.googleAuthLogin()
    }
    
    func googleAuthLogin() {
        self.googleSignIn?.presentingViewController = self
        self.googleSignIn?.clientID = "517555787591-6ee803du1lhbk4kh0qo3cu4dalu2jdbp.apps.googleusercontent.com"
        self.googleSignIn?.delegate = self
        self.googleSignIn?.signIn()
    }
    
    func setupViewAppleBTN() {
        let customAppleLoginBtn = UIButton()
        customAppleLoginBtn.layer.cornerRadius = 25
        customAppleLoginBtn.backgroundColor = UIColor.clear
        customAppleLoginBtn.setImage(UIImage(named: "Group 375"), for: .normal)
        customAppleLoginBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        customAppleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        customAppleLoginBtn.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        view.addSubview(customAppleLoginBtn)
        NSLayoutConstraint.activate([
            customAppleLoginBtn.centerYAnchor.constraint(equalTo: signWihtAppleBTN.centerYAnchor),
            customAppleLoginBtn.centerXAnchor.constraint(equalTo: signWihtAppleBTN.centerXAnchor),
            customAppleLoginBtn.widthAnchor.constraint(equalTo: signWihtAppleBTN.widthAnchor),
            customAppleLoginBtn.heightAnchor.constraint(equalTo: signWihtAppleBTN.heightAnchor),
        ])
    }
    
    @objc func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}




//Google Sing in
extension loginVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard let user = user else {
            print("Uh oh. The user cancelled the Google login.")
            return
        }
        let userId = user.userID ?? ""
        print("Google User ID: \(userId)")
        
        let userIdToken = user.authentication.idToken ?? ""
        print("Google ID Token: \(userIdToken)")
        
        let userFirstName = user.profile.givenName ?? ""
        print("Google User First Name: \(userFirstName)")
        
        let userLastName = user.profile.familyName ?? ""
        print("Google User Last Name: \(userLastName)")
        
        let userEmail = user.profile.email ?? ""
        print("Google User Email: \(userEmail)")
        
        let googleProfilePicURL = user.profile.imageURL(withDimension: 150)?.absoluteString ?? ""
        print("Google Profile Avatar URL: \(googleProfilePicURL)")
        
        self.scailLogin(full_name: "\(userFirstName) \(userLastName)", email: userEmail, social_id: userId)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("User has disconnected")
    }
}


//apple login
extension loginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            print(user)
            self.scailLogin(full_name: "\(user.firstName) \(user.lastName)", email: user.email, social_id: user.id)
        default: break
        }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error", error)
    }
}


extension loginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
