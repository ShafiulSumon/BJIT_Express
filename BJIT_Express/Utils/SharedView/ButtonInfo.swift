//
//  ButtonInfo.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct ButtonInfo: View {
	
	var data: ButtonStatus
	
	var btnColor: Color {
		switch data {
		case .checkIn:
			return .green
		case .checkOut:
			return .red
		case .unavailable:
			return .black
		}
	}
	
	var body: some View {
		Text(data.rawValue)
			.fontWeight(.semibold)
			.fontWidth(.compressed)
			.frame(width: 80, height: 40)
			.background(btnColor)
			.foregroundColor(.white)
			.cornerRadius(8)
			.onTapGesture {
				print(data.rawValue)
			}
	}
}

struct ButtonInfo_Previews: PreviewProvider {
    static var previews: some View {
		ButtonInfo(data: .unavailable)
    }
}
