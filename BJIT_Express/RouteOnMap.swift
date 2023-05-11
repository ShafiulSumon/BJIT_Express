//
//  RouteOnMap.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/10/23.
//

import SwiftUI
import MapKit
import Combine

struct RouteOnMap: View {

	@State var directions: [String] = []
	@State var showDirections: Bool = false

    var body: some View {
		VStack {
			MapView(directions: $directions)

			Button {
				self.showDirections.toggle()
			} label: {
				Text("Show Directions")
			}
			.font(.largeTitle)
			.padding()
		}
		.sheet(isPresented: $showDirections) {
			VStack {
				Text("Directions")
					.font(.largeTitle)
					.bold()
					.padding()
				Divider().background(.red)
				List {
					ForEach(directions, id: \.self) { data in
						Text(data)
					}
				}
				.listStyle(.inset)
			}
		}
    }
}

struct RouteOnMap_Previews: PreviewProvider {
    static var previews: some View {
        RouteOnMap()
    }
}

struct MapView: UIViewRepresentable {
	
	//@Binding var region: MKCoordinateRegion
	//@Binding var destination: CLLocationCoordinate2D
//	@StateObject private var locationManager = LocationManager()
//	@State private var cancellable: AnyCancellable?
	
	@Binding var directions: [String] 
	
	typealias UIViewType = MKMapView
	
	func makeCoordinator() -> MapViewCoordinator {
		return MapViewCoordinator()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()
		
		mapView.delegate = context.coordinator
		
		var region = MKCoordinateRegion(
			center: CLLocationCoordinate2D(
				latitude: 40.71,
				longitude: -74
			),
			span: MKCoordinateSpan(
				latitudeDelta: 0.5,
				longitudeDelta: 0.5
			)
		)
		
		mapView.setRegion(region, animated: true)
		
		// NYC
		let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))
//		let p1 = MKPlacemark(coordinate: region.center)
		
		// Boston
		let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
//		let p2 = MKPlacemark(coordinate: destination)
		
		let request = MKDirections.Request()
		
		request.source = MKMapItem(placemark: p1)
		request.destination = MKMapItem(placemark: p2)
		request.transportType = .automobile
		
		let directions = MKDirections(request: request)
		directions.calculate { response, error in
			guard let route = response?.routes.first else { return }
			mapView.addAnnotations([p1, p2])
			mapView.addOverlay(route.polyline)
			mapView.setVisibleMapRect(
				route.polyline.boundingMapRect,
				edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
				animated: true
			)
			//self.directions = route.steps.map { $0.instructions }.filter( { !$0.isEmpty } )
		}
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
	}
	
	class MapViewCoordinator: NSObject ,MKMapViewDelegate {
		func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
			let renderer = MKPolylineRenderer(overlay: overlay)
			renderer.strokeColor = .blue
			renderer.lineWidth = 3
			return renderer
		}
	}
}
