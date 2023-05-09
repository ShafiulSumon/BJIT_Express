//
//  MapView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/8/23.
//

import SwiftUI
import MapKit

struct MapDetailsView: View {
	
	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(
			latitude: 23.797800880700258,
			longitude: 90.42365144991554
		),
		span: MKCoordinateSpan(
			latitudeDelta: 0.03,
			longitudeDelta: 0.03
		)
	)
	
    var body: some View {
		VStack {
			Map(coordinateRegion: $region)
				.ignoresSafeArea()
		}
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailsView()
    }
}
