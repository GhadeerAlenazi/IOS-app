//
//  LGMASigninViewControllere.swift
//  BeMySight
//
//  Created by احلام المطيري on 29/06/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation

import UIKit



class LGMASigninViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func loginbutton(_ sender: LGMAMyButtons) {
        
        let username = self.username.text!
        let password = self.password.text!

        if(username.isEmpty || password.isEmpty)
        {
            alertMessage(message: "الرجاء تعبئة كافة البيانات ")
        }


        else{
            /* if username == "a" && password == "1" {
             let stuMainPage = self.storyboard?.instantiateViewController(withIdentifier: "welcomepage") as! welcomepage
             let appDelegate = UIApplication.shared.delegate
             appDelegate?.window??.rootViewController = stuMainPage
             } */

let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/signin.php")! as URL)
            request.httpMethod = "POST"


            let postString = "username=\(username)&password=\(password)"
            request.httpBody = postString.data(using: String.Encoding.utf8)

            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        if let parseJson = json{
                            let memberId = parseJson["id"]
                            if(memberId != nil)
                            {

                                UserDefaults.standard.set(parseJson["username"], forKey: "username")
                                UserDefaults.standard.set(parseJson["email"], forKey: "email")
                                UserDefaults.standard.set(parseJson["id"], forKey: "id")
                                UserDefaults.standard.set(parseJson["point"], forKey: "point")

                                let storyboard = UIStoryboard(name: "Volunteer", bundle: nil)
                                let profile = storyboard.instantiateViewController(withIdentifier: "VolunteerViewController") as! VolunteerViewController
                                self?.present(profile, animated: true)                            }
                            else{
                                self!.alertMessage(message: "إسم المستخدم أو كلمة المرور غير صحيحه")
                            }
                        }
                        else{
                            self!.alertMessage(message: "إسم المستخدم أو كلمة المرور غير صحيحه")
                        }


                }
            }
            task.resume()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
let main = UIStoryboard(name: "Main", bundle: nil)
        let gomain = main.instantiateViewController(withIdentifier: "LGMAInitialScreenViewController")
        self.present(gomain, animated: true, completion: nil)
    }
}

//MARK: - extension UITextFieldDelegate
extension LGMASigninViewController: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == username) {
            password.becomeFirstResponder()
            self.view.endEditing(true)
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
}
