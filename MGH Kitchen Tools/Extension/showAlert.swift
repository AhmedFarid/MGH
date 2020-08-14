//
//  showAlert.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "Ok", okHandler: ((UIAlertAction)->Void)? = nil) {
        let messgees = NSLocalizedString(message, comment: "profuct list lang")
        let titles = NSLocalizedString(title, comment: "profuct list lang")
        let alert = UIAlertController(title: titles, message: messgees, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
