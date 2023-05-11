//
//  Test.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import SwiftUI

struct Test: View {
    var body: some View {
		NavigationView {
			NavigationLink {
				NextPage()
			} label: {
				Text("Get Started")
					.font(.title2)
					.frame(
						width: 300,
						height: 60)
					.foregroundColor(.white)
					.background(.black)
					.cornerRadius(30)
			}

		}
    }
}

struct NextPage: View {
	var body: some View {
		Text("this is second page")
			.font(.largeTitle)
			.navigationBarBackButtonHidden()
	}
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

