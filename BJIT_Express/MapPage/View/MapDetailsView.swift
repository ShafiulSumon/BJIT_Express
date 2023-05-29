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

    var body: some View {
		VStack {
			Map(coordinateRegion: $mapDetailsVM.region, showsUserLocation: true, annotationItems: mapDetailsVM.mapLocations) { location in
				MapMarker(coordinate: location.coordinate)
			}
			
			.ignoresSafeArea()
			
//			MapView(region: $region, destination: $mapDetailsVM.destination)
//				.ignoresSafeArea()
//
			
			Spacer()
			
			Text("Estimated Distance: " + String(format: "%.2f", mapDetailsVM.estimatedDistance) + "(KM)")
				.padding([.bottom], 30)
				.font(.title2)
				.foregroundColor(.pink)
			
		}
		.onAppear() {
			mapDetailsVM.setLocation()
		}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailsView()
    }
}
