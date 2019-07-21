//
//  LGMAStepsCountViewController.swift
//  BeMySight
//
//  Created by LGMA on 11/27/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation


class LGMAStepsCountViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var stepsLabelView: UILabel!
    @IBOutlet weak var directionLabelView: UILabel!
    @IBOutlet weak var turnsLabelView: UILabel!
    
    let motionManager = CMPedometer()
    let locationManager = CLLocationManager()
    var prev: String? = nil
    let list = PedometerList()
    var turns = LGMAEnumes.Turns.None.rawValue
    var numberOfsteps: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.stepsLabelView.text = String(self.numberOfsteps)
                print("Steps: \(self.numberOfsteps)")
            }
        }
    }
    
    // MARK: - UIView lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkServicesAvailablity()
    }
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "تعديل", message: "ادخل الطابق في حالة عدم معرفته من قبل الكفيف", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "حفظ", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            // let textField2 = alert.textFields![1] as UITextField
            
            let newusername = textField.text!
            if(newusername == ""){
                self.alertMessage(title: "تنبيه", message: "الرجاء ادخال الطابق")
            }else{
            let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/updaterequest.php")! as URL)
            request.httpMethod = "POST"
            
            let idd = UserDefaults.standard.string(forKey:"request_id")
            
            let postString = "newusername=\(newusername)&id=\( idd!)"
            //"username=\(username)&email=\(email)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
                        self?.alertMessage(title: "تنبيه", message: "تم ادخال الطابق")
                        //UserDefaults.standard.set(newusername, forKey: "username")
                }
            }
            task.resume()
            self.viewDidLoad()
            }
        }
        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "ادخل الطابق "
            textField.textColor = .red
        }
        
        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "إلغاء", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        self.viewDidLoad()
    }
  
    @IBAction func startButtonAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "إبدأ" {
            sender.setTitle("إيقاف", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
            startStepsCounting()
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                startGettingLocationUpdate()
            }
            
        } else if sender.titleLabel?.text == "إيقاف" {
            
            list.append(newValues: (steps: numberOfsteps, turns: nil ?? .None))
            print("--- Stepping is stopped ---")
            if !list.isEmpty {
            alertWithTF()
            }
            sender.setTitle("إبدأ", for: .normal)
            sender.backgroundColor = #colorLiteral(red: 0.3441016674, green: 0.7104439735, blue: 0.9380331039, alpha: 1)
            
            motionManager.stopUpdates()
            locationManager.stopUpdatingHeading()
            //------------------------------
//            if !list.isEmpty {
//                // print(list.printList())
//                list.buildList()
//            }
            //-------------------------
        }
    }
    
    
    @IBAction func sendtoDB(_ sender: Any) {
        if !list.isEmpty {
        // print(list.printList())
            
        list.buildList()
            
        self.alertMessage(title: "شكرا لك", message:"كنت عين لشخص آخر لإيجاد طريقه لقد حصلت على خمس نقاط ")
    }
    }
    
    @IBAction func clearlabel(_ sender: Any) {
        stepsLabelView.text = nil
        turnsLabelView.text = nil
        directionLabelView.text = nil
        motionManager.stopUpdates()
        locationManager.stopUpdatingHeading()
        list.clearPedometerList()
    }
    
    private func updateValues() {
        numberOfsteps = 0
        turns = LGMAEnumes.Turns.None.rawValue
        motionManager.stopUpdates()
        startStepsCounting()
    }
    
    private func saveValues() {

        list.append(newValues: (steps: numberOfsteps, turns: LGMAEnumes.Turns(rawValue: turns) ?? .None))
        
        print("----------- ** Number of steps ** ------------")
        print(numberOfsteps)
        print("----------- ** Turn ** ------------")
        print(turns)
        
        updateValues()
    }
    
    
}

extension LGMAStepsCountViewController: CLLocationManagerDelegate {
    
    func checkServicesAvailablity() {
        if CLLocationManager.locationServicesEnabled() {
            enableLocationServices()
        } else {
            print("Location services is not available on your device.")
        }
    }
    
    private func enableLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    private func startGettingLocationUpdate() {
        locationManager.delegate = self
        locationManager.headingFilter = 30
        locationManager.startUpdatingHeading()
    }

    private func startStepsCounting() {
        
        if CMPedometer.isStepCountingAvailable() {
            
            motionManager.startUpdates(from: Date()) {
                [weak self] pedometerData, error in
                
                if let numberOfSteps = pedometerData?.numberOfSteps {
                    self?.numberOfsteps = Int(truncating: numberOfSteps)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let direction = Int(newHeading.trueHeading)
        
        switch direction {
            case 31...60:
                directionLabelView.text = "North East"
            case 61...120:
                directionLabelView.text = "East"
            case 121...150:
                directionLabelView.text = "East South"
            case 151...210:
                directionLabelView.text = "South"
            case 211...240:
                directionLabelView.text =  "South West"
            case 241...300:
                directionLabelView.text =  "West"
            case 301...330:
                directionLabelView.text =  "North West"
            default:
                directionLabelView.text =  "North"
            
        }
        
        if prev != nil {
            if directionLabelView.text == "East" && prev == "North" {
                turnsLabelView.text = LGMAEnumes.Turns.Right.rawValue
                turns = LGMAEnumes.Turns.Right.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "West" && prev == "North" {
                turnsLabelView.text = LGMAEnumes.Turns.Left.rawValue
                turns = LGMAEnumes.Turns.Left.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "East" && prev == "South" {
                turnsLabelView.text = LGMAEnumes.Turns.Left.rawValue
                turns = LGMAEnumes.Turns.Left.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "West" && prev == "South" {
                turnsLabelView.text = LGMAEnumes.Turns.Right.rawValue
                turns = LGMAEnumes.Turns.Right.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "North" && prev == "East" {
                turnsLabelView.text = LGMAEnumes.Turns.Left.rawValue
                turns = LGMAEnumes.Turns.Left.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "South" && prev == "East" {
                turnsLabelView.text = LGMAEnumes.Turns.Right.rawValue
                turns = LGMAEnumes.Turns.Right.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "North" && prev == "West" {
                turnsLabelView.text = LGMAEnumes.Turns.Right.rawValue
                turns = LGMAEnumes.Turns.Right.rawValue
                saveValues()
                prev = directionLabelView.text!
            } else if directionLabelView.text == "South" && prev == "West" {
                turnsLabelView.text = LGMAEnumes.Turns.Left.rawValue
                turns = LGMAEnumes.Turns.Left.rawValue
                saveValues()
                prev = directionLabelView.text!
            }
        } else {
            prev = directionLabelView.text!
        }
    }
}
