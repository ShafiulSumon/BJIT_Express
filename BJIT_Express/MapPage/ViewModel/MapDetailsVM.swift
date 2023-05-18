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

	private var locationManager = LocationManager()
	var cancellable: AnyCancellable?
	
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
		})
	}
	
//	@Published var destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.50020217895508, longitude: -0.11830687522888184)
}
