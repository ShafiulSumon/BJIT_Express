//
//  MapDetailsVM.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/9/23.
//

import Foundation
import CoreLocation
import Combine
import MapKit

class MapDetailsVM: ObservableObject {

	lazy private var locationManager = LocationManager()
	var cancellable: AnyCancellable?
	@Published var estimatedDistance: Double = -1
	
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(
			latitude: 23.797800880700258,
			longitude: 90.42365144991554
		),
		span: MKCoordinateSpan(
			latitudeDelta: 0.04,
			longitudeDelta: 0.04
		)
	)
	@Published var mapLocations: [MapLocation] = [
		MapLocation(name: "Notun Bazar", latitude: 23.797800880700258, longitude: 90.42365144991554),
		MapLocation(name: "Thomas Hospital", latitude: 51.50020217895508, longitude: -0.11830687522888184)
	]
	
	func setLocation() {
		cancellable = locationManager.$location.sink(receiveValue: { location in
			self.region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
			self.estimatedDistance = self.calculateDistance(from: location?.coordinate ?? CLLocationCoordinate2D(), to: self.mapLocations[0].coordinate)
			
			if(self.estimatedDistance <= 0.1) {
				UserDefaults.standard.set(true, forKey: UDKey.buttonActive.rawValue)
			}
			else {
				UserDefaults.standard.set(false, forKey: UDKey.buttonActive.rawValue)
			}
		})
	}
	
	func calculateDistance(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) -> Double {
		let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
		let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
		
		let distance = sourceLocation.distance(from: destinationLocation) / 1000.0
		
		return distance
	}
	
//	@Published var destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.50020217895508, longitude: -0.11830687522888184)
}
