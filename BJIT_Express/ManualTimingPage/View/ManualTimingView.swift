//
//  ManualTimingView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/19/23.
//

import SwiftUI

struct ManualTimingView: View {
	
	@Binding var arrivalTime: Int
	@State var selectedTime: Date = Date()
    @State var showAlert: Bool = false
	
    var body: some View {
		VStack {
            DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute) {
				Text("Estimated Time")
			}
            .datePickerStyle(.compact)
            .padding([.leading, .trailing], 25)
            
            Spacer().frame(height: 50)
            
            Button("Set Time") {
                let components = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                let hour = components.hour ?? 8
                let minute = components.minute ?? 5
//                arrivalTime = DateManager.makeArrivalTime(hour: hour, minute: minute)
				arrivalTime = (hour*100) + minute
                showAlert.toggle()
            }
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert("Success", isPresented: $showAlert) {
            } message: {
                Text("Estimated time is set properly.")
            }

        }
    }
}

struct ManualTimingView_Previews: PreviewProvider {
    static var previews: some View {
		ManualTimingView(arrivalTime: .constant(0))
    }
}
