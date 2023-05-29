//
//  LocationManager.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/9/23.
//

import Foundation
import MapKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
	@Published var location: CLLocation?
	@Published var insideNotunBazarArea: Bool = false
	
	lazy private var locationManager = CLLocationManager()
	
	override init() {
		super.init()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = kCLDistanceFilterNone
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}
		DispatchQueue.main.async {
			self.location = location
			//self.locationManager.stopUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
		DispatchQueue.main.async {
			self.insideNotunBazarArea = true
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
		DispatchQueue.main.async {
			self.insideNotunBazarArea = false
		}
	}
}

