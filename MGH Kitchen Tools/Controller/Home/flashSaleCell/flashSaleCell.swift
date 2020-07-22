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
    @IBOutlet weak var dayesLB: UILabel!
    @IBOutlet weak var hrLB: UILabel!
    @IBOutlet weak var minLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var add: (()->())?
    
    @IBAction func cartBtnAction(_ sender: Any) {
        add?()
    }
    
    func configureCell(products: productsDataArray){
        
        let date = getDate(toDate: products.expireDateHotDeal ?? "")
        dayesLB.text = "\(date.Days ?? 0) Days"
        hrLB.text = "\(date.Hrs ?? 0) Hrs"
        minLb.text = "\(date.Min ?? 0) Mins"
        
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
    
    func getDate(toDate: String) -> (Days:Int?,Hrs:Int?,Min:Int?) {
        
        let date = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = dateFormatter.string(from: date)
        print(result)
        
        let toDates = dateFormatter.date(from: toDate)
        let diveceDates = dateFormatter.date(from: result)

        
        let diffComponents = Calendar.current.dateComponents([.day,.hour,.minute], from: diveceDates!, to: toDates ?? diveceDates!)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        let day = diffComponents.day
        print("\(day ?? 0) \(hours ?? 0):\(minutes ?? 0)")
        return (day,hours,minutes)
        
    }
    
}



