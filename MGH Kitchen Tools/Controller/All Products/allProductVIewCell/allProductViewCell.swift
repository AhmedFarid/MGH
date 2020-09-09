//
//  allProductViewCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Cosmos

class allProductViewCell: UICollectionViewCell {

    @IBOutlet weak var reviews: CosmosView!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var productImage: imageViewCostom!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var shortDec: UILabel!
    @IBOutlet weak var outSokeLb: UILabel!
    
        var addFav: (()->())?
    var addCart: (()->())?
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func configureCell(products: productsDataArray){
            
            if products.stock ?? 0 <= 0 {
                outSokeLb.text = NSLocalizedString("Out Of Stock", comment: "profuct list lang")
                outSokeLb.textColor = #colorLiteral(red: 0.8509803922, green: 0.1176470588, blue: 0.1490196078, alpha: 1)
                cartBtn.isHidden = true
            }else {
                outSokeLb.text = ""
                cartBtn.isHidden = false
            }
            nameProduct.text = products.name
            shortDec.text = products.shortDescription
            reviews.rating = Double(products.totalRate ?? 0)
            reviews.text = "(\(products.totalNumberReview ?? 0))"
            
            if products.salePrice == products.total {
                discountPrice.isHidden = true
            }else {
                discountPrice.isHidden = false
            }
            newPrice.text = "\(products.total ?? 0) \(products.currency ?? "")"
            discountPrice.text = "\(products.salePrice ?? 0) \(products.currency ?? "")"
            discountPrice.strikeThrough(true)
            if helperAuth.getAPIToken() == nil {
                cartBtn.isHidden = true
                favBtn.isHidden = true
            }else {
                if products.stock ?? 0 <= 0 {
                    cartBtn.isHidden = true
                }else {
                    cartBtn.isHidden = false
                }
                favBtn.isHidden = false
                if products.productInCart == 1 {
                    cartBtn.setImage(UIImage(named: "cart"), for: .normal)
                }else {
                    cartBtn.setImage(UIImage(named: "noCart"), for: .normal)
                }
                if products.isProductFavoirte == 1 {
                    favBtn.setImage(UIImage(named: "fav"), for: .normal)
                }else {
                    favBtn.setImage(UIImage(named: "noFav"), for: .normal)
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
        
        
        
        @IBAction func cartBtnAction(_ sender: Any) {
            addCart?()
        }
        
        @IBAction func favBtnAction(_ sender: Any) {
            addFav?()
        }
    }

