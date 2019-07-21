//
//  LGMARequest_IDViewController.swift
//  BeMySight
//
//  Created by غدير العنزي on 11/07/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
import UIKit
class LGMARequest_IDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblRequest: UITableView!
    var RequestList = [ViewRequestModel]()
    var refreshControl: UIRefreshControl?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblRequest.rowHeight = 170
        getItem()
        addRefreshControl()
    }
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(getItem), for: .valueChanged)
        tblRequest.addSubview(refreshControl!)
    }
    func alertMessage(message: String)
    {
        let alert = UIAlertController(title: "تنبيه", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "حسنا", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func getItem() {
        RequestList.removeAll()
        // hit the web service url
//        let serviceURL = URL(string:"http://localhost/GraduationProject/GetRequestByID.php");
//
//        // download the json data
//        var url = URLRequest(url: serviceURL!)
//        let id = UserDefaults.standard.string(forKey:"id")
//        url.httpMethod = "POST";
//        let postParameter = "id=\(id!)";
//        url.httpBody = postParameter.data(using: String.Encoding.utf8)
//
//        // create  a URL session
//        let session = URLSession(configuration: .default)
//        DispatchQueue.main.async {
//            let task = session.dataTask(with: url, completionHandler:
//            { (data, response, error) in
//
//                if error == nil {
//
//                    self.parseJson(data!)
//
//
//                }else{
//
//                    self.alertMessage(message: (error?.localizedDescription)!)
//                    return
//
//
//                }
//
//            })
//            task.resume()
//        }
//
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/GetRequestByID.php")! as URL)
        //request.httpMethod = "POST"
        
        let id = UserDefaults.standard.string(forKey:"id")
        request.httpMethod = "POST";
        //        let postParameter = "id=\(id!)";
        let postString = "id=\(id!)";
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                    //                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
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
        
        do{
            // parse the data into Informarion struct
            let jsonArray = try JSONSerialization.jsonObject(with: data,
                                                             options: []) as! [Any]
            for jsonResult in jsonArray {
                // cast json result as a dictionary
                let jsonObj = jsonResult as? [String: AnyObject]
                let id = jsonObj?["id"]
                let placename = jsonObj?["place_name"]
                let buildingname = jsonObj?["building_name"]
                let startpoint = jsonObj?["startpoint"]
                let endpoint = jsonObj?["endpoint"]
                let time = jsonObj?["time"]
                let floor = jsonObj?["floor"]
                let arrayofrequest = ViewRequestModel(id: id as! String, place_name: placename as! String, building_name: buildingname as! String, startpoint: startpoint as! String, endpoint: endpoint as! String, time: time as! String, floor: floor as! String)
                
                self.RequestList.append(arrayofrequest)
                
                
            }
            DispatchQueue.main.async {
             
            self.tblRequest.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        catch{
            
            self.alertMessage(message: "لا يوجد طلبات مقبولة")
            self.tblRequest.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LGMAViewRequest_IDTableViewCell
        let Request: ViewRequestModel
        Request = RequestList[indexPath.row]
        cell.Place_Name.text = Request.place_name
        cell.Building_Name.text = Request.building_name
       // cell.Start_Point.text = Request.startpoint
       // cell.End_Point.text = Request.endpoint
      //  cell.Time.text = Request.time
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LGMADetailRequest_IDViewController") as? LGMADetailRequest_IDViewController
        let Request: ViewRequestModel
        Request = RequestList[indexPath.row]
        vc?.id = Request.id
        vc?.palcename = Request.place_name
        vc?.buildingname = Request.building_name
        vc?.startpoint = Request.startpoint
        vc?.endpoint = Request.endpoint
        vc?.time = Request.time
        vc?.Floor = Request.floor
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
}

