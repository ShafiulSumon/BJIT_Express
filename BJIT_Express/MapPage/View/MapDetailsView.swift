//
//  MapView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/8/23.
//

import SwiftUI
import MapKit
import Combine

struct MapDetailsView: View {
	
	@StateObject private var mapDetailsVM = MapDetailsVM()
	@StateObject private var locationManager = LocationManager()
	@State private var cancellable: AnyCancellable?
	
	
	/// Here region is updating by user's current location.
	func setLocation() {
		cancellable = locationManager.$location.sink(receiveValue: { location in
			region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
		})
	}
	
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(
			latitude: 23.797800880700258,
			longitude: 90.42365144991554
		),
		span: MKCoordinateSpan(
			latitudeDelta: 0.04,
			longitudeDelta: 0.04
		)
	)

    var body: some View {
		VStack {
			Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: mapDetailsVM.mapLocations) { location in
				MapMarker(coordinate: location.coordinate)
			}
			.ignoresSafeArea()
			
//			MapView(region: $region, destination: $mapDetailsVM.destination)
//				.ignoresSafeArea()
//
//			Map
			
		}
		.onAppear() {
			setLocation()
		}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailsView()
    }
}
