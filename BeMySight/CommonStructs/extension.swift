//
//  extension.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
