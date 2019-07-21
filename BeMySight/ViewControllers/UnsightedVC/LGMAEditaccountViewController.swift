//
//  LGMAEditaccountViewController.swift
//  BeMySight
//
//  Created by غدير العنزي on 05/08/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import UIKit

class LGMAEditaccountViewController: UIViewController {
   
    
    @IBOutlet weak var usernamelabel: UILabel!

   // @IBOutlet weak var usernameOrEmailLbll: UILabel!
    var selectedCell = Int()
    
    override func viewDidLoad() {
        
        if selectedCell == 1 {
            let username = UserDefaults.standard.string(forKey: "username")
           // print(String(describing:username))
            //usernamelabel.text = String(describing:username)
            self.usernamelabel.text = username
            
        } else if selectedCell == 2 {
            let email = UserDefaults.standard.string(forKey: "email")
            usernamelabel.text = email
        }
    }
   
    @IBAction func onEdit(_ sender: UIBarButtonItem) {
        if selectedCell == 1 {
            alertWithTF()
        } else if selectedCell == 2 {
            alertWithTF2()
        }
    }
    
    
    func isEmailAddressValid(emailTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailTestString)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    func alertWithTF2() {
        //Step : 1
        let alert = UIAlertController(title: "تعديل", message: "ادخل اسم البريد الإلكتروني الجديد", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "حفظ", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            // let textField2 = alert.textFields![1] as UITextField
            
            let newemail = textField.text!
            if(newemail == ""){
                self.alertMessage(title: "تنبيه", message: "الرجاء ادخال البريد الالكتروني")
            }
            else if (!self.isEmailAddressValid(emailTestString: newemail)) {
                self.alertMessage(title: "تنبيه", message: "البريد الالكتروني غير صالح")
            }
            
            else{
            let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/update_email_blind.php")! as URL)
            request.httpMethod = "POST"
            
            let idd = UserDefaults.standard.string(forKey:"blind_id")
            
            let postString = "newemail=\(newemail)&id=\( idd!)"
            //"username=\(username)&email=\(email)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
                        self?.alertMessage(title: "تنبيه", message: "تم التحديث بنجاح")
                        UserDefaults.standard.set(newemail, forKey: "email")
                }
            }
            task.resume()
            }
            self.viewDidLoad()
            
            //let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "editpage")
            //self.present(secondViewController, animated: true, completion: nil)
            
        } //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "ادخل البريد الإلكتروني "
            textField.textColor = .red
        }
        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "إلغاء", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        //OR single line action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })
        self.present(alert, animated: true, completion: nil)
        self.viewDidLoad()
        
    }
    
    
    
    
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "تعديل", message: "ادخل اسم المستخدم الجديد", preferredStyle: UIAlertController.Style.alert)
        //Step : 2
        let save = UIAlertAction(title: "حفظ", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            // let textField2 = alert.textFields![1] as UITextField
            
            let newusername = textField.text!
            if(newusername == ""){
                self.alertMessage(title: "تنبيه", message: "الرجاء ادخال اسم المستخدم")
            }else{
            let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/update_username_blind.php")! as URL)
            request.httpMethod = "POST"
            
            let idd = UserDefaults.standard.string(forKey:"blind_id")
            
            let postString = "newusername=\(newusername)&id=\( idd!)"
            //"username=\(username)&email=\(email)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
                        if error != nil {
                            print("error=\(String(describing: error))")
                            self?.alertMessage(message: (error?.localizedDescription)!)
                            return
                        }
                        
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJson = json {
                            print("response = \(String(describing: response))")
                            
                            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                            print("responseString = \(String(describing: responseString))")
                            let memberMessage = parseJson["message"] as? String
                           
                            if(memberMessage == "عفوا يوجد مستخدم بهذا الاسم"){
                                 self?.alertMessage(message: memberMessage!)
                            }else{
                                UserDefaults.standard.set(newusername, forKey: "username")
                                self?.alertMessage(message: memberMessage!)
                            }
                            return
                        }}}
            task.resume()
                self.viewDidLoad()}
            
        }
        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "ادخل اسم المستخدم "
            textField.textColor = .red
        }
        
        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "إلغاء", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        //OR single line action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })
        
        self.present(alert, animated:true, completion: nil)
        self.viewDidLoad()
    }
    func alertMessage(message: String)
    {
        let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "حسنا", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


    

