//
//  CellView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct CellView: View {
	
	var data: BusInfo
	let user: String
	
	private var hour: Int {
		return data.busDepartureTime/100
	}
	private var minute: Int {
		return data.busDepartureTime%100
	}
	@State private var next: Bool = false
	
	var body: some View {
		VStack {
			Spacer().frame(height: 16)
			HStack {
				Text(data.busId)
					.font(.title2)
					.bold()
					.foregroundColor(!data.isAvailable ? .gray : .black)
				
				Spacer()
				
				VStack {
					Text("\(data.availableSeats)/50")
						.padding(4)
						.fontWeight(.black)
						.border(.gray)
						.background(.gray)
						.foregroundColor(.white)
						.cornerRadius(3)
					Text("\(hour):\(minute) AM")
						.fontWeight(.thin)
				}
				
				Spacer()
				
				
				Button {
					next.toggle()
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
			Spacer().frame(height: 16)
		
//			NavigationLink(isActive: $next, destination: DetailsView(data: data, user: user), label: {
//				EmptyView()
//			})
//			NavigationLink(destination: DetailsView(data: data, user: user), isActive: $next) {
//				EmptyView()
//			}
			
		}
		.disabled(data.isAvailable ? true : false)
	}
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
		CellView(data: BusInfo(), user: "Unknown")
    }
}
