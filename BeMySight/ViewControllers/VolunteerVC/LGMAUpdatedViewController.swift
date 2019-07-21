//
//  LGMAUpdatedViewController.swift
//  BeMySight
//
//  Created by غدير العنزي on 11/07/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
//
//  updated.swift
//  logg
//
//  Created by احلام المطيري on 06/07/1440 AH.
//  Copyright © 1440 احلام المطيري. All rights reserved.
//

import Foundation

import UIKit

class LGMAUpdatedViewController: UIViewController {
    
    @IBOutlet weak var newpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    func isPasswordValid(passwordTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let PaswwordRegEx = "[A-Za-z0-9.-]{8,64}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", PaswwordRegEx)
        return passTest.evaluate(with: passwordTestString)
    }
    @IBAction func updateee(_ sender: Any) {
        
        let newpas = newpass.text!
        
        if (!isPasswordValid(passwordTestString: newpas)) {
            self.alertMessage(title: "تنبيه", message: "كلمة المرور يجب ان لايقل عن  ٨ أحرف و أرقام")
            
        }else{
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/update_pass.php")! as URL)
        request.httpMethod = "POST"
        
        let idd = UserDefaults.standard.string(forKey:"id")
        
        let postString = "newpass=\(newpas)&id=\( idd!)"
        //"username=\(username)&email=\(email)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                     self?.alertMessage(title: "تنبيه", message: "تم التحديث بنجاح")
                    
                   let stuMainPage = self!.storyboard?.instantiateViewController(withIdentifier: "LGMASigninViewController") as! LGMASigninViewController
                   let appDelegate = UIApplication.shared.delegate
                   appDelegate?.window??.rootViewController = stuMainPage
                   
                    
            }
            
            
        }
        task.resume()
        
        }
    }
}
//MARK: - extension UITextFieldDelegate
extension LGMAUpdatedViewController: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == newpass) {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

