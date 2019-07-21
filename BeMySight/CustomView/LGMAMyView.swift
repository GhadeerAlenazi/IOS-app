//
//  LGMAMyView.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit

@IBDesignable class LGMAMyView: UIView {

    
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            mixBothColors()
        }
    }
    
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            mixBothColors()
        }
    }
    
    @IBInspectable var CornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
    @IBInspectable var BorderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = BorderWidth
        }
    }
    
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    private func mixBothColors() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
}
