//
//  LinkedListNode.swift
//  BeMySight
//
//  Created by LGMA on 2/23/19.
//  Copyright © 2019 LGMA. All rights reserved.
//

import Foundation


public class Node {
    var subPedometer: (steps: Int, turns: LGMAEnumes.Turns)
    var next: Node?
    
    init(subPedometer: (steps: Int, turns: LGMAEnumes.Turns)) {
        self.subPedometer.steps = subPedometer.steps
        self.subPedometer.turns = subPedometer.turns
    }
}


class PedometerList {
    
    var head: Node?
    var pedometerListAsString = String()
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public func append(newValues: (steps: Int, turns: LGMAEnumes.Turns)) {
        let newNode = Node(subPedometer: newValues)
        if var head = head {
            while head.next != nil {
                head = head.next!
            }
            head.next = newNode
            
        } else {
            head = newNode
        }
    }
    
    public func clearPedometerList() {
        head = nil
    }
    
    func buildList() {

        var current: Node? = head
        var count = 1
        var turns: String
        while (current != nil) {
            
            pedometerListAsString.append(String(current!.subPedometer.steps))
            pedometerListAsString.append(",")
            turns = current!.subPedometer.turns.rawValue
            if (turns == "Left") {
                pedometerListAsString.append("Left")
            } else if (turns == "Right") {
                 pedometerListAsString.append("Right")
            } else {
                pedometerListAsString.append(contentsOf: "End")
            }
           
               pedometerListAsString.append(":")
            // 
            current = current?.next
            count = count + 1
        }
        print("----------- .. .. .. stepsAsString .. .. .. -------------")
        print(pedometerListAsString)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.6.202.57/GraduationProject/insertNAV.php")! as URL)
        request.httpMethod = "POST"
        let request_id = UserDefaults.standard.string(forKey:"request_id")
        let point = UserDefaults.standard.string(forKey:"point")
        
        var sumpoint = Int(point!)
        sumpoint = sumpoint! + 5
        UserDefaults.standard.set(sumpoint, forKey: "point")
        let id = UserDefaults.standard.string(forKey:"id")
        let postString = "pedometerListAsString=\(pedometerListAsString)&request_id=\(request_id!)&id=\(id!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            [weak self] (data, response, error) -> Void in
            DispatchQueue.main.async
                {
                    
                    
                    //self?.performSegue(withIdentifier: "gostep", sender: self)
            }
        }
        task.resume()
    
    }
}

// @TODO:
extension PedometerList {

}
