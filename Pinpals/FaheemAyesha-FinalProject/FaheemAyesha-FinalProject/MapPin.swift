//
//  MapPin.swift
//  FaheemAyesha-FinalProject
//
//  Created by Ayesha Faheem on 11/26/23.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    var pinColor: UIColor? 

    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D, pinColor: UIColor? = nil) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.pinColor = pinColor
    }
}

