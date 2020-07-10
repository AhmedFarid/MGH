//
//  bannerCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Kingfisher

class bannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(images: slidersData){
        let urlWithoutEncoding = (images.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    func configureCellProducts(images: ProductImage){
        let urlWithoutEncoding = (images.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
