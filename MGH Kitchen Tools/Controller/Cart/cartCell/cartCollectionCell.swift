//
//  cartCollectionCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var productImage: imageViewCostom!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var shortDec: UILabel!
    @IBOutlet weak var qtn: UILabel!
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var totelCartPrice: UILabel!
    
    
    var add: (()->())?
    var min: (()->())?
    var deleteBtn: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(products: productsDataArray){
        newPrice.text = "\(products.total ?? 0) \(products.currency ?? "")"
        nameProduct.text = products.name
        shortDec.text = products.shortDescription
        qtn.text = "\(products.productInCartQty ?? 0)"
        totelCartPrice.text = "\(products.productInCartTotal ?? 0) \(products.currency ?? "")"
        let urlWithoutEncoding = (products.image)
        let encodedLink = urlWithoutEncoding?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    
    @IBAction func datletBtn(_ sender: Any) {
        deleteBtn?()
    }
    
    @IBAction func blusBtn(_ sender: Any) {
         add?()
    }
    
    @IBAction func mainBtn(_ sender: Any) {
        min?()
    }
}
