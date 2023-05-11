//
//  DetailsView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct DetailsView: View {
	@StateObject private var detailsVM = DetailsVM()
	var data: BusInfo
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.teal, .cyan, Color("customColor-1")]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()

			VStack {
				//Spacer().frame(height: 20)
				HStack {
					Text("Available Seats: \(data.availableSeats)(out of 50)")
						.foregroundColor(.white)
						.font(.title3)
						.bold()

					Spacer()

					Button {
						// do something
					} label: {
						if(!data.isAvailable) {
							ButtonInfo(data: .unavailable)
						}
						else {
							if(data.checkIn) {
								ButtonInfo(data: .checkOut)
							}
							else {
								ButtonInfo(data: .checkIn)
							}
						}
					}

				}
				.padding()

				Spacer()

				List {
					Section {
						ForEach(data.passengers, id: \.self) { people in
							Text(people)
						}
						.listRowBackground(Color.clear)
						.foregroundColor(.black)
						.font(.system(size: 22, weight: .semibold, design: .default))
					} header: {
						Text("People are in this bus")
					}

				}
				.scrollContentBackground(.hidden)
				
			}
			.navigationBarTitle("Details")
		}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
		DetailsView(data: BusInfo())
    }
}
