

import Foundation

import UIKit

class LGMAUpdatedpassViewController : UIViewController {
    
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
    func isPasswordValid(passwordTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let PaswwordRegEx = "[A-Za-z0-9.-]{8,64}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", PaswwordRegEx)
        return passTest.evaluate(with: passwordTestString)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    @IBAction func updateee(_ sender: Any) {
        
        let newpass = self.newpass.text!
        if (!isPasswordValid(passwordTestString: newpass)) {
            self.alertMessage(title: "تنبيه", message: "الرقم السري يجب ان لايقل عن  ٨ أحرف و أرقام")}
        else{
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/update_pass_blind.php")! as URL)
        request.httpMethod = "POST"
        
        let idd = UserDefaults.standard.string(forKey:"blind_id")
        
        let postString = "newpass=\(newpass)&blind_id=\( idd!)"
        //"username=\(username)&email=\(email)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                    self?.alertMessage(title: "تنبيه", message: "تم التحديث بنجاح")
//                    let stuMainPage = self!.storyboard?.instantiateViewController(withIdentifier: "LGMALoginViewController") as! LGMALoginViewController
//                    let appDelegate = UIApplication.shared.delegate
//                    appDelegate?.window??.rootViewController = stuMainPage
                    let storyboard = UIStoryboard(name: "Unsighted", bundle: nil)
                    let profile = storyboard.instantiateViewController(withIdentifier: "LGMALoginViewController") as! LGMALoginViewController
                    self?.present(profile, animated: true)
                    
                    
            }
            
            
        }
        task.resume()
        }
        
    }
}
//MARK: - extension UITextFieldDelegate
extension LGMAUpdatedpassViewController: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == newpass) {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
