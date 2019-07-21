//
//  LGMAMyButtons.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit

@IBDesignable class LGMAMyButtons: UIButton {

    @IBInspectable var CornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
}
