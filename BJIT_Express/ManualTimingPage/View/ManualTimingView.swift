//
//  ManualTimingView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/19/23.
//

import SwiftUI

struct ManualTimingView: View {
	
	@Binding var arrivalTime: String
	@State var selectedTime: Date = Date()
	
    var body: some View {
		VStack {
			DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {
				Text("Estimated Time")
			}
			.datePickerStyle(.wheel)
		}
    }
}

struct ManualTimingView_Previews: PreviewProvider {
    static var previews: some View {
		ManualTimingView(arrivalTime: .constant("7: 34 AM"))
    }
}
