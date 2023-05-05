//
//  CellView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct CellView: View {
	
	var data: String
	var available: Int
	
	var body: some View {
		VStack {
			Spacer().frame(height: 16)
			HStack {
				Text(data)
					.font(.title2)
					.bold()
					.foregroundColor((available == -1) ? .gray : .black)
				
				Spacer()
				
				VStack {
					Text("10/50")
						.padding(4)
						.fontWeight(.black)
						.border(.gray)
						.background(.gray)
						.foregroundColor(.white)
					.cornerRadius(3)
					Text("7:30 AM")
						.fontWeight(.thin)
				}
				
				Spacer()
				
				Button {
					//print(data)
				} label: {
					if(available == -1) {
						ButtonInfo(data: .unavailable)
					}
					else if(available == 0) {
						ButtonInfo(data: .checkOut)
					}
					else {
						ButtonInfo(data: .checkIn)
					}
				}
			}
			Spacer().frame(height: 16)
		}
		.disabled((available == -1) ? true : false)
	}
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
		CellView(data: "Bus", available: -1)
    }
}
