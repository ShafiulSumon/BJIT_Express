//
//  HomeView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI

struct HomeView: View {
	
	@State private var arrivalTime: String = "7:30 AM"
	var dummyArray: [String] = ["Bus-A", "Bus-B", "Bus-C", "Bus-D"]
	
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					Text("BJIT Express")
						.font(.title2)
						.bold()
					Spacer()
					HStack {
						Text("Dear, 11695")
							.font(.body)
							.foregroundColor(.gray)
						Image(systemName: "person.circle.fill")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 25, height: 25, alignment: .center)
					}
					.padding()
				}
				.padding()
				.background(Color("customColor-1"))
				.foregroundColor(.white)
				.frame(maxWidth: .infinity)
				.frame(height: 50)
				
				Spacer().frame(height: 20)
				
				HStack {
					Text("Your estimated arrival time: \(arrivalTime)")
						.font(.title2)
						.fontWeight(.light)
						.padding(.leading, 16)
					Spacer()
					Button {
						print("Goto map View")
					} label: {
						VStack {
							Image(systemName: "map")
								.resizable()
								.frame(width: 30, height: 30)
								.padding(8)
							Text("Details")
								.padding(8)
						}
						.background(Color("customColor-1"))
						.foregroundColor(.white)
						.padding(8)
						.cornerRadius(4)
					}
				}
				.background(Color("customColor-2"))
				
				List {
					Section {
						ForEach(dummyArray, id: \.self) { data in
							Text(data)
						}
					} header: {
						Text("Available Bus")
					}
				}
				.listStyle(.insetGrouped)
				
				Spacer()

			}
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}
