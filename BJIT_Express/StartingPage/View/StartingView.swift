//
//  StartingView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI
import CoreData

struct StartingView: View {
	
	private var colorOne = Color(.white)
	private var colorTwo = Color("customColor-2")
	
	@State private var showAlert: Bool = false
	@State private var employeeId: String = ""
	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(sortDescriptors: []) private var employee: FetchedResults<ExpressTable>
	
	
	func saveData() {
		let newEmployee = ExpressTable(context: moc)
		newEmployee.employee_id = employeeId
		do {
			try moc.save()
		}
		catch {
			fatalError("Can't save on CoreData")
		}
	}
	
    var body: some View {
//		NavigationView {
			GeometryReader { geometry in
				ZStack {
					LinearGradient(gradient: Gradient(colors: [colorOne, colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing)
					
					VStack {
						Image("bg-2")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(
								width: geometry.size.width * 1.0,
								height: geometry.size.height * 0.5
							)
						// for rounded the corner
						//------ Start ---------
							.padding(.top, 40)
							.cornerRadius(40)
							.padding(.top, -40)
						// ------- End ---------
//							.ignoresSafeArea()
						
						Text("Welcome to BJIT Express")
							.font(.largeTitle)
							.bold()
							.foregroundColor(Color("customColor-4"))
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
							if !employeeId.isEmpty {
								self.saveData()
							}
							else {
								showAlert.toggle()
							}
						} label: {
							Text("Get Started")
								.font(.title2)
								.frame(
									width: geometry.size.width * 0.9,
									height: 60)
								.foregroundColor(.white)
								.background(Color("customColor-3"))
								.cornerRadius(30)
						}
						.alert("Opps!", isPresented: $showAlert, actions: {}) {
							Text("Please enter your BJIT's employee ID")
						}

						Spacer().frame(height: 30)
					}
				}
			}
//		}
//		.navigationBarBackButtonHidden()
//		.navigationBarTitleDisplayMode(.inline)
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
