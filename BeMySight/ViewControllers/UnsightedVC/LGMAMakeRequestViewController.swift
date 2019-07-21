
    
    import Foundation
    import UIKit
    
    class LGMAMakeRequestViewContoller: UIViewController {
        
        @IBOutlet weak var placename: UITextField!
        @IBOutlet weak var building_name: UITextField!
        @IBOutlet weak var startpoint: UITextField!
        @IBOutlet weak var endpoint: UITextField!
        @IBOutlet weak var time: UITextField!
        @IBOutlet weak var floor: UITextField!
        func alertMessage(message: String) {
            let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "نعم", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            self.view.endEditing(true)
        }
        @IBAction func sendrequest(_ sender: Any) {
            
            if(placename.text!.isEmpty  || endpoint.text!.isEmpty)
            {
                alertMessage(message: "الرجاء تعبئة كافة البيانات ")
            }
            else{
let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/make_request.php")! as URL)
            request.httpMethod = "POST"
            let id = UserDefaults.standard.string(forKey:"blind_id")
            
            let postString = "placename=\(placename.text!)&building_name=\(building_name.text!)&startpoint=\(startpoint.text!)&endpoint=\(endpoint.text!)&time=\(time.text!)&floor=\(floor.text!)&id=\(id!)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
//
//                        let stuMainPage = self?.storyboard?.instantiateViewController(withIdentifier: "LGMAHomePageViewContoller") as! LGMAHomePageViewContoller
//                        let appDelegate = UIApplication.shared.delegate
//                        appDelegate?.window??.rootViewController = stuMainPage
                }
            }
            task.resume()
            
            }
            let alertController = UIAlertController(title: "الحاله", message:
                "تم إرسال الطلب", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
            placename.text = ""
            building_name.text = ""
            startpoint.text = ""
            endpoint.text = ""
            time.text = ""
            floor.text = ""
            
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        
        @IBAction func Clear(_ sender: Any) {
            placename.text = ""
            building_name.text = ""
            startpoint.text = ""
            endpoint.text = ""
            time.text = ""
            floor.text = ""
        }
        
    }


//MARK: - extension UITextFieldDelegate
extension LGMAMakeRequestViewContoller: UITextFieldDelegate {
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == placename) {
            building_name.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == building_name) {
            startpoint.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == startpoint) {
            endpoint.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == endpoint) {
            floor.becomeFirstResponder()
            self.view.endEditing(true)
        }else if(textField == floor) {
            time.becomeFirstResponder()
            self.view.endEditing(true)
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}
