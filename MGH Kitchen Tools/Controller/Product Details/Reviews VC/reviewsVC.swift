//
//  reviewsVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class reviewsVC: UIViewController {

    @IBOutlet weak var reviewTabelVIew: UITableView!
    
    var reviwes = [Review]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reviewTabelVIew.delegate = self
        reviewTabelVIew.dataSource = self
        reviewTabelVIew.register(UINib(nibName: "reviewsCell", bundle: nil), forCellReuseIdentifier: "cell")
        reviewTabelVIew.rowHeight = UITableView.automaticDimension
        reviewTabelVIew.estimatedRowHeight = UITableView.automaticDimension
        setUpNavColore(false, "")
        setUpNav(logo: true, menu: false, cart: true)
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 37"), style: .done, target: self, action: #selector(dismmView))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    @objc func dismmView() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func leaveReviewsBtnAction(_ sender: Any) {
        let vc =  writeRewiewVC(nibName: "writeRewiewVC", bundle: nil)
        vc.productId = id
        self.navigationController!.pushViewController(vc, animated: true)
       
    }
    
    

}


extension reviewsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviwes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = reviewTabelVIew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? reviewsCell {
            cell.configureCell(images: reviwes[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return reviewsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
