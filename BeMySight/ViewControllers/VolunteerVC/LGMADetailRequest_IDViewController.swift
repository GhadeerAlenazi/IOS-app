//
//  LGMADetailRequest_IDViewController.swift
//  BeMySight
//
//  Created by غدير العنزي on 11/07/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import UIKit
class LGMADetailRequest_IDViewController: UIViewController {
    
    @IBOutlet weak var PlaceName: UILabel!
    
    @IBOutlet weak var BuildingName: UILabel!
    
    @IBOutlet weak var StartPoint: UILabel!
    @IBOutlet weak var EndPoint: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    
    @IBOutlet weak var floor: UILabel!
    var id = ""
    var palcename = ""
    var buildingname = ""
    var startpoint = ""
    var endpoint = ""
    var time = ""
    var Floor = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaceName.text = palcename
        BuildingName.text = buildingname
        StartPoint.text = startpoint
        EndPoint.text = endpoint
       Time.text = time
        floor.text = Floor
    }
    
//
    @IBAction func complete(_ sender: Any) {
let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/specifc_request.php")! as URL)
        
        request.httpMethod = "POST"
        
        
            let postString = "request_id=\(id)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
        
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                [weak self] (data, response, error) -> Void in
                DispatchQueue.main.async
                    {
        
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
        
                        UserDefaults.standard.set(json!["id"], forKey: "request_id")
        
                        //self?.performSegue(withIdentifier: "gostep", sender: self)
                }
            }
            task.resume()
//            performSegue(withIdentifier: "StartRote", sender: self)
        }
    
    
    //

    
    @IBAction func Delete(_ sender: Any) {
//        let serviceURL = URL(string:"http://localhost/GraduationProject/deleteAcceptedRequest.php");
//
//        // download the json data
//        var url = URLRequest(url: serviceURL!)
//        let idd = UserDefaults.standard.string(forKey:"id")
//
//        url.httpMethod = "POST";
//        let postParameter = "request_id=\(id)&sighted_id=\(idd!)";
//        url.httpBody = postParameter.data(using: String.Encoding.utf8)
//
//        // create  a URL session
//        let session = URLSession(configuration: .default)
//        DispatchQueue.main.async {
//            let task = session.dataTask(with: url, completionHandler:
//            { (data, response, error) in
//
//                if error == nil {
//                    // succeeded
//
//                    //call the parse json function on the data
//
//                    //self.parseJson(data!)
//                    self.alertMessage(message: "تم حذف الطلب  ")
//                }
//                else{
//
//
//                }
//
//            })
//            task.resume()
//        }
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/x.php")! as URL)
        //request.httpMethod = "POST"
        
        let idd = UserDefaults.standard.string(forKey:"id")
        
        request.httpMethod = "POST";
        let postString = "request_id=\(id)&sighted_id=\(idd!)";
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                    //                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if(error == nil){
                        self!.alertMessage(message: " تم الحذف")
                        
                    }
                        
                    else{
                        self!.alertMessage(message: " يوجد خطأ")
                    }
                    
                    
            }
        }
        task.resume()

    }
    
    
func alertMessage(message: String)
{
    let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "نعم", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
}

}
