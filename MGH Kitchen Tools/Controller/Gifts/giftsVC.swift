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
    
    var giftsArry = [giftsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftsCollecionView.register(UINib(nibName: "giftCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        giftsCollecionView.delegate = self
        giftsCollecionView.dataSource = self
        
        giftsGet()
    }
    
    @IBAction func closseBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func giftsGet() {
        giftsApi.giftslApi{ (error,success,giftsArry) in
            if let giftsArry = giftsArry{
                self.giftsArry = giftsArry.data ?? []
                print(giftsArry)
                self.giftsCollecionView.reloadData()
            }
        }
    }
    
    func GetGiftForUse(gift_id: String,giftValue:String,giftType: String) {
        giftsApi.getGift(gift_id: gift_id) { (error, success, message) in
            if success == true {
                if message?.success == true {
                let alert = UIAlertController(title: "Congratulations", message: "You are get Gift \(giftType) \(giftValue)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}


extension giftsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GetGiftForUse(gift_id: "\(giftsArry[indexPath.row].id ?? 0)", giftValue: "\(giftsArry[indexPath.row].giftValue ?? "")", giftType: giftsArry[indexPath.row].type ?? "")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftsArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = giftsCollecionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? giftCell {
          cell.configureCell(products: giftsArry[indexPath.row])
            return cell
        }else {
            return giftCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
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
