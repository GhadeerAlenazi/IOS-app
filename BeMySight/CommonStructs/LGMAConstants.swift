//
//  ASConstants.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import Foundation
import UIKit


struct LGMAConstants {
    struct StoryboardID {
        static let NotificationViewControllerID = "Notification"
        static let WelcomeViewControllerID = "Welcome"
        static let HelpViewControllerID = "Help"
        static let ThanksViewControllerID = "Thanks"
        static let PopupViewControllerID = "Popup"
    }
    
    struct Segues {
        static let UsersSegue = "usersViewControllerSegue"
        static let UnsightedSegue = "toUnsightedFlow"
        static let VolunteerSegue = "toVolunteerFlow"
    }
}
