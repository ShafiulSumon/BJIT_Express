//
//  TopBarView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/12/23.
//

import SwiftUI

struct TopBarView: View {
	
	var user: String
	
    var body: some View {
		HStack {
			Text("BJIT Express")
				.font(.title)
				.bold()
			Spacer()
			HStack {
				Text("Dear, \(user)")
					.fixedSize(horizontal: false, vertical: true)
					.font(.system(size: 14))
					.foregroundColor(.gray)
					.lineLimit(nil)
					.multilineTextAlignment(.trailing)
				Image(systemName: "person.circle.fill")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 25, height: 25, alignment: .center)
			}
			.padding()
		}
		.frame(height: 50)
		.padding()
		.background(Color("customColor-3"))
		.foregroundColor(.white)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(user: "Unknown")
    }
}
