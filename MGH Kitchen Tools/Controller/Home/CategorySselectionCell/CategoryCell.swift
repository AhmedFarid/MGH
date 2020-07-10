//
//  CategoryCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/5/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var catIamge: imageViewCostom!
    @IBOutlet weak var catName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    func configureCell(images: dataCategoriesArray){
        catName.text = images.name
        let urlWithoutEncoding = (images.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        catIamge.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            catIamge.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}

