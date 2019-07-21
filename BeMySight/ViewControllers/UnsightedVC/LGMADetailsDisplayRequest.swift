//
//  LGMADetailsDisplayRequest.swift
//  BeMySight
//
//  Created by غدير العنزي on 04/08/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import UIKit
class LGMADetailsDisplayRequest: UIViewController {
    
    
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
    
    
    
    @IBAction func StartRote(_ sender: Any) {

        
        
            
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
//                        let stuMainPage = self!.storyboard?.instantiateViewController(withIdentifier: "LGMADisplauRoteViewController") as! LGMADisplauRoteViewController
//                        let appDelegate = UIApplication.shared.delegate
//                        appDelegate?.window??.rootViewController = stuMainPage
                        let storyboard = UIStoryboard(name: "Unsighted", bundle: nil)
                        let profile = storyboard.instantiateViewController(withIdentifier: "LGMADisplauRoteViewController") as! LGMADisplauRoteViewController
                        self?.present(profile, animated: true)
                      
                }
                            }
            task.resume()
    
        }
    
    
    
}
