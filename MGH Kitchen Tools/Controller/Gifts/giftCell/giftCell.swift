//
//  giftCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class giftCell: UICollectionViewCell {

    @IBOutlet weak var iamge: UIImageView!
    @IBOutlet weak var idGift: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(products: giftsData){
        idGift.text = "\(products.id ?? 0)"
       
    }
    
    
    

}
