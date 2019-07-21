//
//  ViewRequestModel.swift
//  BeMySight
//
//  Created by غدير العنزي on 06/07/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import Foundation
class ViewRequestModel {
    var id: String
    var place_name: String
    var building_name: String
    var startpoint: String
    var endpoint: String
    var  time: String
    var floor: String
    
    init(id: String, place_name:String, building_name:String,startpoint: String, endpoint: String, time: String, floor: String ) {
        self.id = id
        self.place_name = place_name
        self.building_name = building_name
        self.startpoint = startpoint
        self.endpoint = endpoint
        self.time = time
        self.floor = floor
    }
}
