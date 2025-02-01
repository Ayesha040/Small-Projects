//
//  SinglePinMeet.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/26/23.
//

import UIKit

class SinglePinMeet {
    var friendName: String?
    var title: String?
    var longitude: Double?
    var latitude: Double?
    var isActive: Bool?
    var dateTime: NSDate?
    var eventID: String?
    var seconds: Int?
    
    init(friendName: String, title: String, longitude: Double, latitude: Double, isActive: Bool, dateTime: NSDate, eventID: String, seconds: Int) {
        self.friendName = friendName
        self.title = title
        self.longitude = longitude
        self.latitude = latitude
        self.isActive = isActive
        self.dateTime = dateTime
        self.eventID = eventID
        self.seconds = seconds
    }
}

