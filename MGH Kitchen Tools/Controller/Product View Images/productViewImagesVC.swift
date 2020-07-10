//
//  productViewImagesVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productViewImagesVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var sizesImage: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imageGuide = String()
    var images = [ProductImage]()
    var productID = Int()
    var selected = Int()
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.imagesCollectionView.register(UINib.init(nibName: "imageCells", bundle: nil), forCellWithReuseIdentifier: "cell")
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        print("Image :::::: \(self.imageGuide)")
        if selected == 1 {
            imagesCollectionView.isHidden = false
            sizesImage.isHidden = true
            imagesHandleRefresh()
        }else{
            scroll.delegate = self
            imagesCollectionView.isHidden = true
            sizesImage.isHidden = false
            imageGuideRefresh()
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
            tapRecognizer.numberOfTapsRequired = 2
            view.addGestureRecognizer(tapRecognizer)
        }
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {    super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @objc fileprivate func imagesHandleRefresh() {
        let element = images.remove(at: index)
        images.insert(element, at: 0)
        self.imagesCollectionView.reloadData()
    }
    
    func imageGuideRefresh(){
        let urlWithoutEncoding = (self.imageGuide)
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        sizesImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            sizesImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sizesImage
    }
    
    @objc func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        let scale = min(scroll.maximumZoomScale, scroll.maximumZoomScale)
        
        if scale != scroll.zoomScale {
            let point = gestureRecognizer.location(in: sizesImage)
            
            let scrollSize = scroll.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scroll.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(CGRect(origin: origin, size: size))
        }else if scale == scroll.maximumZoomScale{
            scroll.zoom(to:CGRect(origin: scroll.frame.origin, size: scroll.frame.size), animated: true)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
extension productViewImagesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! imageCells
        cell.configureCell(image: images[indexPath.item].image ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.height)
    }
    
}
