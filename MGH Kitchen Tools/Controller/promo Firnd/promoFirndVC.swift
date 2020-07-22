//
//  promoFirndVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class promoFirndVC: UIViewController {

    @IBOutlet weak var promoText: UILabel!
    @IBOutlet weak var promoCodeText: UILabel!
    
    var Promo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)
        promoCodeText.text = "\(Promo)"
    }
    @IBAction func copyPromo(_ sender: Any) {
        UIPasteboard.general.string = Promo
        showAlert(title: "Promo", message: "Promo Code Copy")
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        let textToShare = [ Promo ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)

    }
}
