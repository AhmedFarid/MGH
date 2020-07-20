//
//  flashSaleCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class flashSaleCell: UICollectionViewCell {

    @IBOutlet weak var reviews: CosmosView!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var productImage: imageViewCostom!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var discountPrcent: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var shortDescraption: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureCell(products: productsDataArray){
        discountPrcent.text = "\(products.discount ?? 0) \(products.currency ?? "")"
        reviews.rating = Double(products.totalRate ?? 0)
        reviews.text = "(\(products.totalNumberReview ?? 0))"
        nameProduct.text = products.name
        shortDescraption.text = products.shortDescription
        if products.salePrice == 0 {
            discountPrice.isHidden = true
        }else {
            discountPrice.isHidden = false
        }
        newPrice.text = "\(products.total ?? 0) \(products.currency ?? "")"
        discountPrice.text = "\(products.salePrice ?? 0) \(products.currency ?? "")"
        discountPrice.strikeThrough(true)
        if helperAuth.getAPIToken() == nil {
            cartBtn.isHidden = true
        }else {
            cartBtn.isHidden = false
            if products.productInCart == 1 {
                cartBtn.setImage(UIImage(named: "cart"), for: .normal)
            }else {
                cartBtn.setImage(UIImage(named: "noCart"), for: .normal)
            }
        }
        let urlWithoutEncoding = (products.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    
    @IBAction func cartBTNAction(_ sender: Any) {
    }
    
}
