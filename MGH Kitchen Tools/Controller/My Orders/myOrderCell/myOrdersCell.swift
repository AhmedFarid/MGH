//
//  myOrdersCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class myOrdersCell: UICollectionViewCell {

    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var orderQntyLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(products: myOrdersData){
        orderIdLabel.text = "Order Id: \(products.id ?? 0)"
        orderTotalLabel.text = "Total Price: \(products.total ?? 0) \(products.orderDetails?.first?.currency ?? "")"
        orderQntyLabel.text = "Order Quantity: \(products.orderDetails?.count ?? 0)"
    }
    
}
