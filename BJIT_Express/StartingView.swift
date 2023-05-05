//
//  StartingView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI
import CoreData

struct StartingView: View {
	
	var colorOne = Color(.white)
	var colorTwo = Color("customColor-2")
//	var colorTwo = Color(red: 255/255, green: 241/255, blue: 220/255)
//	var colorTwo = Color(red: 130/255, green: 170/255, blue: 227/255)
	
	@State private var employeeId: String = ""
	
    var body: some View {
		GeometryReader { geometry in
			ZStack {
				LinearGradient(gradient: Gradient(colors: [colorOne, colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing)
					.ignoresSafeArea()
					
				VStack {
					Image("bg-2")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(
							width: geometry.size.width * 1.0,
							height: geometry.size.height * 0.4
						)
						// for rounded the corner
						//------ Start ---------
						.padding(.top, 40)
						.cornerRadius(40)
						.padding(.top, -40)
						// ------- End ---------
					
					Text("Welcome to BJIT Express")
						.font(.largeTitle)
						.bold()
//						.foregroundColor(Color(red: 7/255, green: 10/255, blue: 82/255))
						.foregroundColor(Color("customColor-1"))
						.multilineTextAlignment(.center)
					Text("For the first time we need your employee id")
						.font(.body)
						.foregroundColor(.gray)
						.padding(.top, 5)
					
					Spacer().frame(height: 30)
					
					TextField("Your Employee Id", text: $employeeId)
						.frame(width: geometry.size.width * 0.8, height: 60, alignment: .center)
						.textFieldStyle(.roundedBorder)
					
					Spacer()
					
					Button {
						// do something
					} label: {
						Text("Get Started")
							.font(.title2)
							.frame(
								width: geometry.size.width * 0.9,
								height: 60)
							.foregroundColor(.white)
							.background(.black)
							.cornerRadius(30)
					}
					Spacer().frame(height: 30)

				}
			}
		}
		
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
