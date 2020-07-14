//
//  writeRewiewVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos
import NVActivityIndicatorView

class writeRewiewVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var commentTV: UITextView!
    @IBOutlet weak var reviewBtn: CosmosView!
    
    var productId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: true)
        // Do any additional setup after loading the view.
    }


    @IBAction func commentBtnAction(_ sender: Any) {
        loaderHelper()
        favoriteApi.setReviewApi(product_id: "\(productId)", review: Int(reviewBtn.rating), comment: commentTV.text ?? "") { (error, success, message) in
            if success {
                self.stopAnimating()
                let alert = UIAlertController(title: "Rewiew", message: "Your Rewiew Is Success", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    let vc = homeVC(nibName: "homeVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            self.stopAnimating()
        }
    }
}
