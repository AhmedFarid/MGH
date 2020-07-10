//
//  textFieldView.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit


@IBDesignable
class textFieldView: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.layer.bounds.height/2
        }
    }
    
    
    @IBInspectable var cornerRadiuscostom: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadiuscostom
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear{
        didSet{
            self.layer.shadowColor  = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0{
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset  : CGSize = CGSize.zero{
        didSet{
            self.layer.shadowOffset  = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            self.layer.shadowRadius  = shadowRadius
        }
    }
    
    
    @IBInspectable var leftPaddingPointss : CGFloat = 10{
        didSet{
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPaddingPointss, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable var rightPaddingPointss : CGFloat = 10{
        didSet{
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPaddingPointss, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable var imageHeight : Int = 0 {
        didSet{
        }
    }
    
    
    
    @IBInspectable var imageWidth : Int = 0 {
        didSet {
            
        }
    }
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            mainView.layer.cornerRadius = 5
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            view.clipsToBounds = true
            view.layer.cornerRadius = 5
            view.layer.borderWidth = CGFloat(0)
            view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mainView.addSubview(view)
            
            let imageView = UIImageView(image: rightImage)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
            view.addSubview(imageView)
            
            let seperatorView = UIView()
            seperatorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mainView.addSubview(seperatorView)
            
            
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
            
            
            self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.layer.borderWidth = CGFloat(2)
            self.layer.cornerRadius = self.layer.bounds.height/2
            
        }
    }
    
    @IBInspectable var leftImage : UIImage? {
        didSet {
            let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
            mainView.layer.cornerRadius = 5
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            view.clipsToBounds = true
            view.layer.cornerRadius = 5
            view.layer.borderWidth = CGFloat(0)
            view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mainView.addSubview(view)
            
            let imageView = UIImageView(image: leftImage)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
            view.addSubview(imageView)
            
            let seperatorView = UIView()
            seperatorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            mainView.addSubview(seperatorView)
            
            
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
            
            self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.layer.borderWidth = CGFloat(2)
            self.layer.cornerRadius = self.layer.bounds.height/2
            
        }
    }
    
    @IBInspectable var placeholderColor : UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor!])
            attributedPlaceholder = str
        }
    }
}


