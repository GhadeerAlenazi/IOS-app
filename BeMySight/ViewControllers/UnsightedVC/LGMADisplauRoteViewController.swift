//
//  LGMADisplauRoteViewController.swift
//  BeMySight
//
//  Created by LGMA on 04/08/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import AVFoundation
import  UIKit
class LGMADisplauRoteViewController: UIViewController {
    
    public var roate_id: String = ""
    var mypath = [String]()
    var BackPath = [String]()
    
    @IBOutlet weak var displaypath: UILabel!
    var count = -1
    var back = false
    public var i: Int = 0
    public var displaySubPath: String = ""
    public var displaySubPath2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getroute()
        
        
    }
    
    
    @IBAction func nextpath(_ sender: UIButton) {
        if(displaypath.text == "لقد وصلت الى وجهتك"){
           sender.isEnabled = false
           // count = -3
        }
        
         count = count + 1
        if(count != mypath.count){
            displaySubPath = mypath[count]
           //BackPath[back] = mypath[count]
            let subPath = displaySubPath.components(separatedBy: ",")
            print(subPath)
            if(subPath.count == 2){
                var turns: String = ""
                if (subPath[1] == "Right"){
                    turns = "يمين"
                    displaypath.text = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                    displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                }else if(subPath[1] == "Left"){
                    turns = "يسار"
                    displaypath.text = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                    displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                }else{
                    turns = ""
                    displaypath.text = "الرجاء التقدم \(String(subPath[0])) خطوات"
                    displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات"
                }
                
//                displaypath.text = "الرجاد التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
//                displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                
                
            }else
            {
                displaypath.text = "لقد وصلت الى وجهتك"
                displaypath.accessibilityLabel = "لقد وصلت الى وجهتك"
                let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/CheckFav.php")! as URL)
                request.httpMethod = "POST"
                let blind_id = UserDefaults.standard.string(forKey:"blind_id")
                let postString = "route_id=\(self.roate_id)&blind_id=\(blind_id!)"
                
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
                                //self.alertMessage(message: memberMessage!)
                               // return
                                if(memberMessage == "لا يوجد"){
                                    let alert = UIAlertController(title: "لقد وصلت الى وجهتك هل تؤد حفظ هذا المسار في مفضلتك؟", message: "", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                                        print("yes")
                                        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/toFavorit.php")! as URL)
                                        request.httpMethod = "POST"
                                        let blind_id = UserDefaults.standard.string(forKey:"blind_id")
                                        // return
                                        //  let route_id = UserDefaults.standard.string(forKey:"id")
                                        let postString = "blind_id=\(blind_id!)&route_id=\(self.roate_id)"
                                        
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
                                        
                                        
                                    }))
                                    
                                    alert.addAction(UIAlertAction(title: "لا", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
                                        print("no")
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }}}
                task.resume()
 
            }
        
        }
        print("count in next2: \(count)")
        }
    func alertMessage(message: String)
    {
        let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "نعم", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)}
    
    @IBAction func Exit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Unsighted", bundle: nil)
        let profile = storyboard.instantiateViewController(withIdentifier: "BlindViewController") as! BlindViewController
        self.present(profile, animated: true)
    }
    
    @IBAction func Previous(_ sender: Any) {
         print("count in pre0: \(count)")
        count = count - 1
        print("count in pre1: \(count)")
        if(count >= 0){
            
        displaySubPath2 = mypath[count]
        let subPath = displaySubPath2.components(separatedBy: ",")
        if(subPath.count == 2){
            var turns: String = ""
            if (subPath[1] == "Right"){
                turns = "يمين"
            }else{
                turns = "يسار"
            }
            
            displaypath.text = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
            displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
            
            }
            
        }
        else{
            displaySubPath2 = mypath[0]
            let subPath = displaySubPath2.components(separatedBy: ",")
            
            if(subPath.count == 2){
                var turns: String = ""
                if (subPath[1] == "Right"){
                    turns = "يمين"
                }else{
                    turns = "يسار"
                }
                
                displaypath.text = "الرجاد التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
                displaypath.accessibilityLabel = "الرجاء التقدم \(String(subPath[0])) خطوات ومن ثم انعطف \(turns)"
            }
            print("count in pre2: \(count)")
            count = count + 1
        }
        //count = count + 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //prepareForSpeaking()
    }
    
    func getroute() {
  
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/GetRoat.php")! as URL)
        let blind_id = UserDefaults.standard.string(forKey:"blind_id")
        let idd = UserDefaults.standard.string(forKey:"request_id")
        request.httpMethod = "POST";
        //        let postParameter = "id=\(id!)";
        let postString = "blind_id=\(blind_id!)&id=\(idd!)";
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                    if(error == nil){
                        self?.parseJson(data!)
                        
                    }
                        
                    else{
                        self!.alertMessage(message: " يوجد خطأ")
                    }
                    
                    
            }
        }
        task.resume()
        
        
        
        
        
    }
    func parseJson(_ data: Data){
        var getdirection = [String]()
        do{
            // parse the data into Informarion struct
            
            let jsonArray = try JSONSerialization.jsonObject(with: data,
                                                             options: []) as! [Any]
            for jsonResult in jsonArray {
                // cast json result as a dictionary
                let jsonObj = jsonResult as? [String: String]
                roate_id = (jsonObj?["id"] ?? nil)!
                let Direction = jsonObj?["direction"]

                getdirection.append(Direction!)
   
            }
        }
            
        catch {
            DispatchQueue.main.async {
                
            self.displaypath.text = "عفوا طلبك لم يكتمل حتى الآن "
                self.displaypath.accessibilityLabel = "عفوا طلبك لم يكتمل حتى الآن "
            }
        }
        //---------------------compare which array is short -----------------------
        if(getdirection.count != 0){
        var i: Int = 1
        var fullpath = getdirection[0].components(separatedBy: ":")
        while (i < getdirection.count){
            let compared = getdirection[i].components(separatedBy: ":")
            if (compared.count < fullpath.count){
                fullpath = getdirection[i].components(separatedBy: ":")
            }
            i = i + 1
        }
        print("fullpath: \(fullpath)")
        mypath = fullpath
        //---------------------end -----------------------
        }else{
         self.displaypath.text = "عفوا طلبك لم يكتمل حتى الآن "
            self.displaypath.accessibilityLabel = "عفوا طلبك لم يكتمل حتى الآن "
        }}
}
