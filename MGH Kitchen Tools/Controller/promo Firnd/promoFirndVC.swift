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
    
    var Promo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)
        promoText.text = "Your Promo code Is \(Promo)"
    }

    @IBAction func shareBtn(_ sender: Any) {
        let textToShare = [ Promo ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)

    }
}
