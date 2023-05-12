//
//  TopBarView2.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/12/23.
//

import SwiftUI

struct TopBarView2: View {
	
	let user: String
	
    var body: some View {
		VStack {
			HStack {
				Text("BJIT Express")
					.font(.title2)
					.bold()
					.foregroundColor(.white)
				
				Spacer()
				
				HStack {
					Text("Dear, \(user)")
						.font(.body)
						.foregroundColor(.gray)
					
					Spacer().frame(width: 10)
					
					Image(systemName: "person.circle.fill")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 25, height: 25, alignment: .center)
						.foregroundColor(.white)
				}
			}
			.frame(height: 50)
			.padding()
			.background(Color("customColor-3"))
		}
    }
}

struct TopBarView2_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView2(user: "Employee")
    }
}
