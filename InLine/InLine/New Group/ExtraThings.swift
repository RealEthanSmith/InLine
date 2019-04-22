//
//  ExtraThings.swift
//  InLine
//
//  Created by Emmett Shaughnessy on 4/21/19.
//  Copyright © 2019 Emmett Shaughnessy. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation



extension ViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}
