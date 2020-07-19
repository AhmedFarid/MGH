//
//  giftsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class giftsVC: UIViewController {
    
    @IBOutlet weak var giftsCollecionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftsCollecionView.register(UINib(nibName: "giftCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        giftsCollecionView.delegate = self
        giftsCollecionView.dataSource = self
    }
    
    @IBAction func closseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension giftsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = giftsCollecionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? giftCell {
            //cell.configureCell(images: categorie[indexPath.row])
            return cell
        }else {
            return giftCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
//        let screenWidth =
//
//        var width = (screenWidth - 10)/3
//
//        width = width < 100 ? 130 : width
        
        return CGSize.init(width: collectionView.bounds.width/3.0, height: collectionView.bounds.width/3.0)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
