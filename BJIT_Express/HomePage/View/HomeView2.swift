//
//  HomeView2.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/12/23.
//

import SwiftUI

struct HomeView2: View {
	
	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(sortDescriptors: []) private var employee: FetchedResults<ExpressTable>
	@State private var arrivalTime: String = "7:34 AM"
	@StateObject private var homeVM = HomeVM()
	@State private var user: String = "Employee"
	
    var body: some View {
		NavigationStack {
			VStack(spacing: 0) {
				TopBarView2(user: user)
				Spacer()
			}
		}
		.onAppear {
			user = employee.last?.employee_id ?? "Employee"
		}
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}
