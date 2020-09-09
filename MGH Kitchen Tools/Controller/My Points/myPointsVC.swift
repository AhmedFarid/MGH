//
//  myPointsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 8/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import MOLH

class myPointsVC: UIViewController {

    @IBOutlet weak var myPointsLb: UILabel!
    @IBOutlet weak var profieNoteLb: UILabel!
    @IBOutlet weak var pointsLabe: UILabel!
    @IBOutlet weak var pointsValue: UILabel!
    
    var points = ""
    var profielNote = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(false, "")
        setUpNav(logo: true, cart: true)
        
        if MOLHLanguage.currentAppleLanguage() == "ar"{
            self.pointsLabe.text = "اجمالي النقاط"
            
            self.myPointsLb.text = "نقاطي"
        }
        pointsValue.text = points
        profieNoteLb.text = profielNote.html2String
        
        
    }

}
