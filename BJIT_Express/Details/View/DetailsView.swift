//
//  DetailsView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import SwiftUI

struct DetailsView: View {
	var available: ButtonStatus
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.teal, .cyan, Color("customColor-1")]), startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack {
				//Spacer().frame(height: 20)
				HStack {
					Text("Available Seats: 17/50")
						.foregroundColor(.white)
					.font(.title3)
					.bold()
					
					Spacer()
					
					Button {
						
					} label: {
						ButtonInfo(data: available)
					}

				}
				.padding()
				
				Spacer()
			}
			.navigationBarTitle("Details")
		}
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
		DetailsView(available: .unavailable)
    }
}
