//
//  MapDetailsVM.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/9/23.
//

import Foundation
import CoreLocation

class MapDetailsVM: ObservableObject {

	@Published var mapLocations: [MapLocation] = [
		MapLocation(name: "Notun Bazar", latitude: 23.797800880700258, longitude: 90.42365144991554),
		MapLocation(name: "Thomas Hospital", latitude: 51.50020217895508, longitude: -0.11830687522888184)
	]
	
//	@Published var destination: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.50020217895508, longitude: -0.11830687522888184)
}
