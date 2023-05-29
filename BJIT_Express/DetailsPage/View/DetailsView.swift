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
	@Binding var alreadyInBus: Bool
	var user: String
	
	@State private var showAlert: Bool = false
	@State private var alertMessage: String = ""
	@State private var flag = false
	
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [ Color("customColor-2"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
				.ignoresSafeArea()

			VStack {
				TopBarView(user: user)
				
				HStack {
					Text("Available Seats: \(data.availableSeats-data.passengers.count)(out of 50)")
						.font(.title3)
						.bold()

					Spacer()
					
					Button {
						if(!UserDefaults.standard.bool(forKey: UDKey.buttonActive.rawValue)) {
							alertMessage = "You need to reach nearby of Natun Bazar Area"
							showAlert.toggle()
						}
						else if(!data.isAvailable) {
							alertMessage = "This bus is not available right now"
							showAlert.toggle()
						}
						else {
							//global -> true
							if(UserDefaults.standard.bool(forKey: UDKey.global_check_in.rawValue)) {
								// if this is my bus
								if(UserDefaults.standard.string(forKey: UDKey.my_allocated_bus.rawValue) == data.busId) {
									flag = false
									data.passengers.removeAll(where: { $0 == user })
									UserDefaults.standard.set(false, forKey: UDKey.global_check_in.rawValue)
									UserDefaults.standard.set("", forKey: UDKey.my_allocated_bus.rawValue)
									detailsVM.update(busInfo: data)
								}
								else { // other bus
									// do nothing, or show some alert
									alertMessage = "You've already Checked-In in another bus"
									showAlert.toggle()
								}
							}
							else { //global -> false
								UserDefaults.standard.set(true, forKey: UDKey.global_check_in.rawValue)
								UserDefaults.standard.set(data.busId, forKey: UDKey.my_allocated_bus.rawValue)
								flag = true
								data.passengers.append(user)
								detailsVM.update(busInfo: data)
							}
						}
					} label: {
						if(!data.isAvailable) {
							ButtonInfo(data: .unavailable)
						}
						else {
							if flag {
								ButtonInfo(data: .checkOut)
							}
							else {
								ButtonInfo(data: .checkIn)
							}
						}
					}
					.alert("Error", isPresented: $showAlert) {
						//
					} message: {
						Text(alertMessage)
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
		.onAppear {
			// global -> false
			if(!UserDefaults.standard.bool(forKey: UDKey.global_check_in.rawValue)) {
				flag = false
			}
			else {
				// my allocated bus
				if(UserDefaults.standard.string(forKey: UDKey.my_allocated_bus.rawValue) == data.busId) {
					flag = true
				}
				else {
					flag = false
				}
			}
		}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
		DetailsView(data: .constant(BusInfo()), alreadyInBus: .constant(false), user: "Unknown")
    }
}
