//
//  LGMALoginViewController.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit
import AVFoundation

class LGMALoginViewController: UIViewController {
    
        @IBOutlet weak var username: UITextField!
        @IBOutlet weak var password: UITextField!
    
        @IBOutlet weak var scrollView: UIScrollView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view, typically from a nib.
            //step 1: add tap gesture to view
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
//            view.addGestureRecognizer(tapGesture)
        }
//    //step 7
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        addObservers()
//    }
//    //step 8
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        removeObservers()
//    }
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
    
    @IBAction func loginbutton(_ sender: Any) {
    
    let username = self.username.text!
            let password = self.password.text!

            if(username.isEmpty || password.isEmpty)
            {
                alertMessage(message: "الرجاء تعبئة كافة البيانات ")
            }
        
                
            else{
             
                let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/signin_blind.php")! as URL)
                request.httpMethod = "POST"


                let postString = "username=\(username)&password=\(password)"
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

                                    let storyboard = UIStoryboard(name: "Unsighted", bundle: nil)
                                    let profile = storyboard.instantiateViewController(withIdentifier: "BlindViewController") as! BlindViewController
                                    self?.present(profile, animated: true)

                                    // self?.alertMessage(message: "آهلا بك مجدداً")
                                }
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
extension LGMALoginViewController: UITextFieldDelegate {
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
//    // step 2 : add method to handle tap event on the view and dismiss keyboard
//    @objc func didTapView(gesture: UITapGestureRecognizer){
//        self.view.endEditing(true)
//    }
//    // step 3: add observers for UIKeyboardWillShow and UIKeyboardWillHide notification.
//    func addObservers(){
//        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil)
//        { notification in
//            self.keyboardWillShow(notification: notification)
//        }
//        NotificationCenter.default.addObserver(forName: nil, object: nil, queue: nil)
//        { notification in
//            self.keyboardWillHide(notification: notification)
//        }
//    }
//    // step 4
//    func keyboardWillShow(notification: Notification){
//        guard let userInfo = notification.userInfo,
//            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue else {
//                return
//        }
//        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
//        scrollView.contentInset = contentInset
//    }
//    //step 5
//    func keyboardWillHide(notification: Notification){
//        scrollView.contentInset = UIEdgeInsets.zero
//    }
//    // step6
//    func removeObservers(){
//        NotificationCenter.default.removeObserver(self)
//    }
//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 250), animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
}




