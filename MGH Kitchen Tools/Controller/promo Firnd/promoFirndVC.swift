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
    @IBOutlet weak var promoAV: UILabel!
    
    var Promo = ""
    var isAve = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)
        promoCodeText.text = "\(Promo)"
        
        if isAve == "yes" {
            promoAV.text = NSLocalizedString("Ready for used", comment: "profuct list lang")
            promoAV.textColor = #colorLiteral(red: 0.2235294118, green: 0.6705882353, blue: 0.3215686275, alpha: 1)
            
        }else {
            promoAV.text = NSLocalizedString("Used", comment: "profuct list lang")
            promoAV.textColor = #colorLiteral(red: 0.8509803922, green: 0.1176470588, blue: 0.1490196078, alpha: 1)
        }
    }
    @IBAction func copyPromo(_ sender: Any) {
        UIPasteboard.general.string = Promo
        showAlert(title: "Promo", message: "Promo Code Copy")
    }
    
    @IBAction func shareBtn(_ sender: Any) {
        let textToShare = [ Promo, "https://apps.apple.com/us/app/id1523040737"]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)

    }
}
