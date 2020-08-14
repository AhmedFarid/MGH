//
//  cartCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCells: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var qtnLB: UILabel!
    @IBOutlet weak var unitProduct: UILabel!
    @IBOutlet weak var totalPirce: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(products: productsDataArray){
        productName.text = products.name
        qtnLB.text = "\(NSLocalizedString("Quantity", comment: "profuct list lang")) \(products.productInCartQty ?? 0)"
        totalPirce.text = "\(NSLocalizedString("Total Price", comment: "profuct list lang")) \(products.productInCartTotal ?? 0) \(products.currency ?? "")"
        unitProduct.text = "\(NSLocalizedString("Price", comment: "profuct list lang")) \(products.total ?? 0) \(products.currency ?? "")"
    }
    
}
