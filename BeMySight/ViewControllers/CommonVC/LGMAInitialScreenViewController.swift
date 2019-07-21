//
//  LGMAInitialScreenViewController.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit
import AVFoundation

class LGMAInitialScreenViewController: UIViewController {

    let speachSynthize = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //prepareForSpeaking()
    }
    
    
    
    @IBAction func sighted(_ sender: Any) {
        
        performSegue(withIdentifier: "sighted", sender: self)
    }
    
    @IBAction func blind(_ sender: Any) {
        
        performSegue(withIdentifier: "blind", sender: self)
    }
    
}
