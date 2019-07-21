//
//  AlertViewCustom.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit

class AlertViewCustom: UIView {

    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertHeaderLabel: UILabel!
    @IBOutlet weak var alertDescriptionLabel: UILabel!
    
    
    let nibName = "AlertViewCustom"
    var contentView: UIView!
    var time: Timer?
    

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        alertHeaderLabel.text = String()
        alertDescriptionLabel.text = String()
    }
    
    
    func set(image: UIImage) {
        self.alertImageView.image = image
    }
    
    func set(headline: String) {
        self.alertHeaderLabel.text = headline
    }
    
    func set(subheading: String) {
        self.alertDescriptionLabel.text = subheading
    }

    override func didMoveToSuperview() {
        // Animate fade in.
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in
            // Add a timer to remove the view
            self.time = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: true)
        }
    }
    
     override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    @objc private func removeSelf() {
        
        // Animate fade out.
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
