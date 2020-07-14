//
//  reviewsCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class reviewsCell: UITableViewCell {
    
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(images: Review){
        rateView.rating = Double(images.review ?? 0)
        dateLabel.text = images.createdAt
        nameLabel.text = images.customer?.fullName
        commentLabel.text = images.comment
        
    }
    
}
