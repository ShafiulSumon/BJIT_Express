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
	
	private var locationManager = CLLocationManager()
	
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
			self.locationManager.stopUpdatingLocation()
		}
	}
}

//extension MKCoordinateRegion {
//
//	static func goldenGateRegion() -> MKCoordinateRegion {
//		MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.819527098978355, longitude:  -122.47854602016669), latitudinalMeters: 5000, longitudinalMeters: 5000)
//	}
//
//	func getBinding() -> Binding<MKCoordinateRegion>? {
//		return Binding<MKCoordinateRegion>(.constant(self))
//	}
//}
