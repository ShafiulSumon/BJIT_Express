//
//  HomeView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI

enum ButtonStatus: String {
	case checkIn = "Check-In"
	case checkOut = "Check-Out"
	case unavailable = "X"
}

struct HomeView: View {
	
	@State private var arrivalTime: String = "7:32 AM"
	@StateObject private var homeVM = HomeVM()
	
	var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				
//			MARK: - TopBar View
				HStack {
					Text("BJIT Express")
						.font(.title2)
						.bold()
					Spacer()
					HStack {
						Text("Dear, Md Shafiul Alam")
							.font(.body)
							.foregroundColor(.gray)
							.fixedSize(horizontal: false, vertical: true)
							.lineLimit(nil)
							.multilineTextAlignment(.trailing)
						Image(systemName: "person.circle.fill")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 25, height: 25, alignment: .center)
					}
					.padding()
				}
				.frame(height: 50)
				.padding()
				.background(Color("customColor-1"))
				.foregroundColor(.white)
				.frame(maxWidth: .infinity)
				
				//Spacer().frame(height: 50)
				
				
//			MARK: - Estimated time section
				HStack {
					Text("Your estimated arrival time: \(arrivalTime)")
						.font(.title2)
						.fontWeight(.light)
						.padding(.leading, 16)
					Spacer()
					
					NavigationLink() {
						MapDetailsView()
					} label: {
						VStack {
							Spacer()
							Image(systemName: "map")
								.resizable()
								.frame(width: 30, height: 30)
								.padding(8)
							Text("Show Map")
								.padding(8)
							Spacer()
						}
						.background(Color("customColor-1"))
						.foregroundColor(.white)
					}
				}
				.frame(height: 100)
				.border(.white)
				.background(Color("customColor-2"))
				

//			MARK: - Available Bus List
				List {
					Section {
						ForEach(homeVM.dummyArray, id: \.self) { data in
							NavigationLink {
								if(data == "Bus-A") {
									DetailsView(available: .unavailable)
								}
								else if(data == "Bus-B") {
									DetailsView(available: .checkOut)
								}
								else {
									DetailsView(available: .checkIn)
								}
							} label: {
								if(data == "Bus-A") {
									CellView(data: data, available: -1)
								}
								else if(data == "Bus-B") {
									CellView(data: data, available: 0)
								}
								else {
									CellView(data: data, available: 1)
								}
							}
													}
					} header: {
						Text("Available Bus")
					}
				}
				.listStyle(.insetGrouped)
			}
		}
	}
}


struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}

