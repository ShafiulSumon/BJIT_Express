//
//  HomeView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI

enum ButtonStatus: String {
	case checkIn = "Check-In"
	case checkOut = "Check-Out"
	case unavailable = "X"
}

struct HomeView: View {
	
	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(sortDescriptors: []) private var employee: FetchedResults<ExpressTable>
	@State private var arrivalTime: String = "7:34 AM"
	@StateObject private var homeVM = HomeVM()
	@State private var user: String = "Employee"
	
	@available(iOS 14.0, *)
	var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				
//			MARK: - TopBarView
				TopBarView(user: user)
				
				
//			MARK: - Estimated time section
				HStack {
					Text("Your estimated arrival time: \(arrivalTime)")
						.font(.title2)
						.fontWeight(.light)
						.padding(.leading, 16)
					Spacer()

					NavigationLink() {
//						MapDetailsView()
						ManualTimingView(arrivalTime: $arrivalTime)
					} label: {
						VStack {
							Spacer()
							Image(systemName: "map")
								.resizable()
								.frame(width: 30, height: 30)
								.padding(8)
							Text("Show Map")
								.padding(8)
							Spacer()
						}
						.background(Color("customColor-4"))
						.foregroundColor(.white)
					}
				}
				.frame(height: 110)
				.border(.white)
				.background(Color("customColor-2"))


//			MARK: - Available Bus List
				List {
					Section {
						ForEach(0..<homeVM.BusArray.count, id: \.self) { index in
							NavigationLink {
								DetailsView(data: $homeVM.BusArray[index], alreadyInBus: $homeVM.alreadyInBus, user: user)
							} label: {
								CellView(data: $homeVM.BusArray[index])
							}
						}
					} header: {
						Text("Available Bus")
					}
				}
				.listStyle(.insetGrouped)
			}
		}
		.onAppear {
			user = employee.last?.employee_id ?? "Employee"
		}
	}
}


struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}

