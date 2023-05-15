//
//  DetailsView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct DetailsView: View {
	
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@StateObject private var detailsVM = DetailsVM()
	@Binding var data: BusInfo
	var user: String
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [ Color("customColor-2"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
				.ignoresSafeArea()

			VStack {
				TopBarView(user: user)
				
				HStack {
					Text("Available Seats: \(data.availableSeats)(out of 50)")
						.font(.title3)
						.bold()

					Spacer()

					Button {
						//print("DetailsView")
						if(data.isAvailable) {
							data.checkIn.toggle()
						}
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
				
				if(data.passengers.isEmpty) {
					Image(systemName: "figure.walk.motion")
						.resizable()
						.frame(width: 120, height: 180)
						.foregroundColor(Color("customColor-3"))
					Spacer()
				}
				else {
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
				
			}
			
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						self.presentationMode.wrappedValue.dismiss()
					}, label: {
						Image(systemName: "chevron.left")
							.aspectRatio(contentMode: .fill)
							.frame(width: 60, height: 60)
							.background(Color("customColor-4"))
							.foregroundColor(.white)
							.cornerRadius(30)
							.padding()
							.shadow(color: .gray, radius: 7, x: 7, y: 7)
					})
					.padding()
					Spacer().frame(width: 24)
				}
				.zIndex(100)
			}
			.navigationBarBackButtonHidden()
		}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
		DetailsView(data: .constant(BusInfo()), user: "Unknown")
    }
}
