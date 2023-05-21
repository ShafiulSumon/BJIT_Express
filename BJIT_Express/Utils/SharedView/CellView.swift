//
//  CellView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct CellView: View {
	
	@Binding var data: BusInfo
	
//	private var hour: Int {
//		return data.busDepartureTime/100
//	}
//	private var minute: String {
//		let min = data.busDepartureTime%100
//		return String(format: "%02d", min)
//	}
    
    private var arrivalTime: String {
        return DateManager.makeArrivalTime(hour: data.busDepartureTime/100, minute: data.busDepartureTime%100)
    }
	
	var body: some View {
		VStack {
			Spacer().frame(height: 16)
			HStack {
				Text(data.busId)
					.font(.title2)
					.bold()
					.foregroundColor(!data.isAvailable ? .gray : .black)
				
				Spacer().frame(width: 50)
				
				VStack {
					Text("\(data.availableSeats)/50")
						.padding(4)
						.fontWeight(.black)
						.border(.gray)
						.background(.gray)
						.foregroundColor(.white)
						.cornerRadius(3)
					Text(arrivalTime)
						.fontWeight(.thin)
				}
				
				Spacer()
				
				if(data.isAvailable) {
					Text(data.checkIn ? "Check-Out" : "Check-In")
						.font(.caption)
						.fontWeight(.black)
						.foregroundColor(data.checkIn ? .red : .green)
						.shadow(radius: 0.8)
				}
				else {
					Text("Not Avilable")
						.font(.caption)
						.fontWeight(.black)
				}
			}
			Spacer().frame(height: 16)
		}
		.disabled(data.isAvailable ? true : false)
	}
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
		CellView(data: .constant(BusInfo()))
    }
}
