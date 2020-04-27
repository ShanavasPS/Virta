//
//  MapManager.swift
//  Virta
//
//  Created by Shaji Shanavas on 27.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import Foundation
import MapKit
class MapManager {
    
    func showNavigation(name: String, latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
