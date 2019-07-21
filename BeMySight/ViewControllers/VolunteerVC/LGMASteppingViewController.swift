//
//  LGMASteppingViewController.swift
//  BeMySight
//
//  Created by LGMA on 3/24/19.
//  Copyright © 2019 LGMA. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class LGMASteppingViewController: UIViewController {

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var stepBackButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopStartButton: UIButton!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var stepCountLabel: UILabel!
    
    let list = PedometerList()
    var turns: String = LGMAEnumes.Turns.None.rawValue {
        didSet {
            
        }
    }
    var numberOfSteps: Int = 0 {
        didSet {
            stepCountLabel.text = String(numberOfSteps)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // 1. Enable Stepeing ..
        // 2. Enable location ..
        // 3. Start counting ..
        isButtonEnabled(false)
    }
    
    private func isButtonEnabled(_ value: Bool) {
        rightButton.isEnabled = value
        leftButton.isEnabled = value
        stepButton.isEnabled = value
        stepBackButton.isEnabled = value
        resetButton.isEnabled = value
        
        leftView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    @IBAction func stepsCounting(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            print((sender.titleLabel?.text)!)
            // Right turn case.
            // 1. Save number of steps and turn direction.
            // 2. Reset counter to 0.
            if numberOfSteps > 0 {
                leftView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                rightView.backgroundColor = #colorLiteral(red: 0.3473536968, green: 0.7089859843, blue: 0.938128233, alpha: 1)
                list.append(newValues: (steps: numberOfSteps, turns: LGMAEnumes.Turns.Right))
                numberOfSteps = 0
            }
        case 2:
            print((sender.titleLabel?.text)!)
            // Left turn case
            // 1. Save number of steps and turn direction.
            // 2. Reset counter to 0.
            if numberOfSteps > 0 {
                rightView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                leftView.backgroundColor = #colorLiteral(red: 0.3473536968, green: 0.7089859843, blue: 0.938128233, alpha: 1)
                list.append(newValues: (steps: numberOfSteps, turns: LGMAEnumes.Turns.Left))
                numberOfSteps = 0
            }
        case 3:
            print((sender.titleLabel?.text)!)
            // Step in case
            // 1. Go one step ahead.
            numberOfSteps = numberOfSteps + 1
        case 4:
            print((sender.titleLabel?.text)!)
            // Step back case
            // 1. Go one step back.
            if numberOfSteps > 0 {
                numberOfSteps = numberOfSteps - 1
            }
        case 5:
            print((sender.titleLabel?.text)!)
            // Reset case
            // 1. Reset counter to 0 and clear list.
            numberOfSteps = 0
            list.clearPedometerList()
        default:
            print("Nothing ...")
        }
        
    }
    
    @IBAction func onStopStart(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "بداية" {
            sender.setTitle("نهاية", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
            isButtonEnabled(true)
            
        } else if sender.titleLabel?.text == "نهاية" {
            sender.setTitle("بداية", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
            // If steps is equal or bigger than 1, and save remaining steps to the list.
            if numberOfSteps > 0 {
                list.append(newValues: (steps: numberOfSteps, turns: LGMAEnumes.Turns.None))
            }
            
            list.buildList()
            isButtonEnabled(false)
        }
    }
}
