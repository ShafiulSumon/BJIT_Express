//
//  MapLocation.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/9/23.
//

import Foundation
import CoreLocation

struct MapLocation: Identifiable {
	var id = UUID().uuidString
	var name: String
	var latitude: Double
	var longitude: Double
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
}
