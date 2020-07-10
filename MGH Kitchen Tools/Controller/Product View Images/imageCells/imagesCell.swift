//
//  imagesCell.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class imagesCell: UICollectionViewCell,UIScrollViewDelegate {
        @IBOutlet weak var scroll: UIScrollView!
        @IBOutlet weak var productImage: UIImageView!
        
        func configureCell(image: String) {
            let urlWithoutEncoding = (image)
            let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let encodedURL = NSURL(string: encodedLink!)! as URL
            productImage.kf.indicatorType = .activity
            if let url = URL(string: "\(encodedURL)") {
                productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
            }
        }
        
        
        override func awakeFromNib() {
            super.awakeFromNib()
            scroll.delegate = self
            scroll.minimumZoomScale = 1
            scroll.maximumZoomScale = 3.5
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return productImage
        }
        
    }
