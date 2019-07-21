//
//  LGMASignUpViewController.swift
//  BeMySight
//
//  Created by غدير العنزي on 19/06/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import UIKit

class LGMASignUpViewContoller: UIViewController {
    
    
    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    func isEmailAddressValid(emailTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailTestString)
    }
    func isPasswordValid(passwordTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let PaswwordRegEx = "[A-Za-z0-9.-]{8,64}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", PaswwordRegEx)
        return passTest.evaluate(with: passwordTestString)
    }
    func showAlert(title: String, msg: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    @IBAction func SigUp(_ sender: Any) {
     
        if (UserName.text == "" || Password.text == "" || Email.text == "") {
            
            self.alertMessage(message: "الرجاء إدخال جميع الحقول")
        }else if (!isEmailAddressValid(emailTestString: Email.text!)) {
            self.alertMessage(message: "البريد الالكتروني غير صالح")
            
        }
            
        else if (!isPasswordValid(passwordTestString: Password.text!)) {
            self.alertMessage(message: " يجب أن لا تقل كلمة المرور عن ثمانية أحرف وأرقام" )
            
        }
        else{
            let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/SignUp.php")! as URL)
            request.httpMethod = "POST"
            
            let postString = "username=\(UserName.text!)&password=\(Password.text!)&email=\(Email.text!)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                DispatchQueue.main.async
                    {
                        if error != nil {
                            print("error=\(String(describing: error))")
                            self.alertMessage(message: (error?.localizedDescription)!)
                            return
                        }
                        
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJson = json {
                            print("response = \(String(describing: response))")
                            
                            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            print("responseString = \(String(describing: responseString))")
                            let memberMessage = parseJson["message"] as? String
                            self.alertMessage(message: memberMessage!)
                            return
                        }}}
            task.resume()
            
            
    
            UserName.text = ""
            Password.text = ""
            Email.text = ""
        }}
    func alertMessage(message: String)
    {
        let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "حسنا", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - extension UITextFieldDelegate
extension LGMASignUpViewContoller: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if(textField == UserName) {
            Password.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == Password) {
            Email.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == Email) {
            textField.resignFirstResponder()
        }
        return true
    }
}
