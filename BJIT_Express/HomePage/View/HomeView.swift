//
//  HomeView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI

struct HomeView: View {
	
	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(sortDescriptors: []) private var employee: FetchedResults<ExpressTable>
	@FetchRequest(sortDescriptors: []) private var busInformation: FetchedResults<BusInformation>
	@State private var arrivalTime: Int = 0
	@StateObject private var homeVM = HomeVM()
	@State private var user: String = "Employee"
	@State private var indicatorIsHidden: Bool = true
	
	@available(iOS 14.0, *)
	var body: some View {
		
//	MARK: - Timer
		let timer = Timer.publish(every: 20, on: .main, in: .default).autoconnect()
		
		NavigationView {
			VStack(spacing: 0) {
				
//			MARK: - TopBarView
				TopBarView(user: user)
				
				
//			MARK: - Estimated time section
				HStack {
					Text("Your estimated arrival time: " + DateManager.makeArrivalTime(hour: arrivalTime/100, minute: arrivalTime%100))
						.font(.title2)
						.fontWeight(.light)
						.padding(.leading, 16)
					Spacer()

					NavigationLink() {
						VStack {
							MapDetailsView()
							ManualTimingView(arrivalTime: $arrivalTime)
						}
						.padding()
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
				ZStack {
					List {
						Section {
							ForEach(0..<homeVM.BusArray.count, id: \.self) { index in
								NavigationLink {
									DetailsView(data: $homeVM.BusArray[index], alreadyInBus: $homeVM.alreadyInBus, user: user)
								} label: {
									CellView(data: $homeVM.BusArray[index])
										.background(.green)
								}
								
							}
						} header: {
							Text("Available Bus")
						}
					}
					.listStyle(.insetGrouped)
					.refreshable {
						homeVM.fetch(reset: false, moc: moc){}
					}
					.onReceive(timer) { _ in
						homeVM.indicatorIsHidden = false
						//homeVM.refreshDataSet()
						//						homeVM.manualAvailabilityCheck(arrivalTime: arrivalTime)
						homeVM.fetch(reset: false, moc: moc){}
					}
					
					Image("sad-face")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 200, height: 200)
						.isHidden(homeVM.BusArray.count==0 ? false : true)

					ProgressView()
						.progressViewStyle(.circular)
						.tint(Color("customColor-3"))
						.isHidden(homeVM.indicatorIsHidden)
				}
			}
		}
		.onAppear {
			user = employee.last?.employee_id ?? "Employee"
//			homeVM.populateDataSet {
//				//homeVM.fetch(reset: false, moc: moc)
//			}
			homeVM.fetch(reset: false, moc: moc) {
				// Everyday Reset Data
				if(homeVM.BusArray.last?.infoDate != DateManager.currentDate()) {
					//Delete data.
					homeVM.fetch(reset: true, moc: moc){}
					homeVM.populateDataSet {
						homeVM.fetch(reset: false, moc: moc){}
					}
				}
			}
			
			// fetch
			//homeVM.fetch(reset: false, moc: moc){}
			
			// reset
//			homeVM.fetch(reset: true, moc: moc)
		}
	}
}


struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}



