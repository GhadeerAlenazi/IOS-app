//
//  LGMARecoverpassViewController.swift
//  BeMySight
//
//  Created by LGMA on 11/07/1440 AH.
//  Copyright © 1440 LGMA All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class LGMARecoverpassViewController: UIViewController {
    
  
        @IBOutlet weak var username: UITextField!
        @IBOutlet weak var email: UITextField!
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        func alertMessage(message: String)
        {
            let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "نعم", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        @IBAction func loginbu(_ sender: Any) {
            
            
            let username = self.username.text!
            let email = self.email.text!
            
            if(username.isEmpty || email.isEmpty)
            {
                alertMessage(message: "الرجاء تعبئة كافة البيانات ")
            }
                
                
            else{
let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/recover_pass_blind.php")! as URL)
                request.httpMethod = "POST"
                
                
                let postString = "username=\(username)&email=\(email)"
                request.httpBody = postString.data(using: String.Encoding.utf8)
                
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    [weak self] (data, response, error) -> Void in
                    DispatchQueue.main.async
                        {
                            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            if let parseJson = json{
                                let memberId = parseJson["blind_id"]
                                if(memberId != nil)
                                {
                                    
                                    UserDefaults.standard.set(parseJson["username"], forKey: "username")
                                    UserDefaults.standard.set(parseJson["email"], forKey: "email")
                                    UserDefaults.standard.set(parseJson["blind_id"], forKey: "blind_id")
//                                       let stuMainPage = self!.storyboard?.instantiateViewController(withIdentifier: "LGMAUpdatedpassViewController") as! LGMAUpdatedpassViewController
//                                      let appDelegate = UIApplication.shared.delegate
//                                     appDelegate?.window??.rootViewController = stuMainPage
                                    let storyboard = UIStoryboard(name: "Unsighted", bundle: nil)
                                    let profile = storyboard.instantiateViewController(withIdentifier: "LGMAUpdatedpassViewController") as! LGMAUpdatedpassViewController
                                    self?.present(profile, animated: true)
                                    // self?.alertMessage(message: "آهلا بك مجدداً")
                                }
                                else{
                                    self!.alertMessage(message: "إسم المستخدم أو البريد الإلكتروني غير صحيح")
                                }
                            }
                            else{
                                self!.alertMessage(message: "إسم المستخدم أو البريد الإلكتروني غير صحيح")
                            }
                            
                            
                    }
                }
                task.resume()
            }
        }
    }
    
//MARK: - extension UITextFieldDelegate
extension LGMARecoverpassViewController: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == username) {
            email.becomeFirstResponder()
            self.view.endEditing(true)
        }else {
            textField.resignFirstResponder()
        }
        return true
}
    
}
    
    

    

