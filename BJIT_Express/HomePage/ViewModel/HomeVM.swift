//
//  Model.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import Foundation
import SwiftUI
import CloudKit
import CoreData


class HomeVM: ObservableObject {
	
//	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(entity: BUS.entity(), sortDescriptors: []) private var cdBus: FetchedResults<BUS>
	
	@Published var BusArray: [BusInfo] = []
	@Published var alreadyInBus: Bool = false
	@Published var indicatorIsHidden: Bool = true
	static var cnt = 1
	
	func populateDataSet(completion: @escaping () -> Void) {
//		for bus in Buses.buses {
//			self.save(busInfo: bus)
//			self.BusArray.append(bus)
//			print(bus.infoDate)
//		}
		UserDefaults.standard.set(false, forKey: UDKey.global_check_in.rawValue)
		UserDefaults.standard.set("", forKey: UDKey.my_allocated_bus.rawValue)
		
		let apiQueue = DispatchQueue(label: "com.express.api")
		apiQueue.async {
			for bus in Buses.buses {
				self.save(busInfo: bus)
				self.BusArray.append(bus)
				print(bus.recordID as Any)
			}
		}
	}
	
//	func refreshDataSet() {
//		DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//			if(HomeVM.cnt%2 == 0) {
//				self.BusArray = []
//			}
//			else {
//				self.BusArray = Buses.buses
//			}
//			HomeVM.cnt += 1
//			self.indicatorIsHidden = true
//		}
//	}
	
	func save(busInfo: BusInfo) {
		CKManager.shared.save(busInfo: busInfo) { busInfo in
			if busInfo != nil {
				print("Data save successfully!!")
			}
		}
	}
	
	func fetch(reset: Bool, moc: NSManagedObjectContext, completion: @escaping ()-> Void) {
		BusArray = []
		CKManager.shared.fetch { [weak self] busArray in
			DispatchQueue.main.async {
				
				if(reset) {
					self?.BusArray = []
					self?.BusArray = busArray.sorted()
					self?.reset(moc: moc)
					return
				}
				
				var tempArray: [BusInfo] = busArray.sorted()
				
				
				//Business Logic
				
				for i in 0..<tempArray.count {
					
					if(tempArray[i].isAvailable) {
						if(tempArray[i].busDepartureTime <= DateManager.currentHourMinute()) {
							if(tempArray[i].passengers.count < 15 && !tempArray[i].checkIn) {
								tempArray[i].busDepartureTime += 1
								tempArray[i].checkIn = true
								CKManager.shared.update(recordID: tempArray[i].recordID!, newValues: tempArray[i].toDictionary()) { newRecord, error in
									guard error == nil else {
										print(error as Any)
										return
									}
									print("success update")
								}
							}
							else {
								tempArray[i].isAvailable = false
								CKManager.shared.update(recordID: tempArray[i].recordID!, newValues: tempArray[i].toDictionary()) { newRecord, error in
									guard error == nil else {
										print(error as Any)
										return
									}
									print("success update")
								}
							}
						}
					}
					
					
					
//					if(!tempArray[i].isAvailable) {
//						continue
//					}
//					if(tempArray[i].busDepartureTime <= DateManager.currentHourMinute()) {
//						if(tempArray[i].passengers.count < 15 && !tempArray[i].checkIn) {
//							tempArray[i].busDepartureTime += 2
//							tempArray[i].checkIn = true
//							CKManager.shared.update(recordID: tempArray[i].recordID!, newValues: tempArray[i].toDictionary()) { newRecord, error in
//								guard error == nil else {
//									print(error as Any)
//									return
//								}
//								print("success update")
//							}
//						}
//						else {
//							if(tempArray[i].isAvailable) {
//								tempArray[i].isAvailable = false
//								CKManager.shared.update(recordID: tempArray[i].recordID!, newValues: tempArray[i].toDictionary()) { newRecord, error in
//									guard error == nil else {
//										print(error as Any)
//										return
//									}
//									print("success update")
//								}
//							}
//						}
//					}
				}
				self?.BusArray = []
				self?.BusArray = tempArray
				self?.indicatorIsHidden = true
			}
		}
	}
	
	func reset(moc: NSManagedObjectContext) {
		
		for i in 0..<self.BusArray.count {
			let newBusInformation = BusInformation(context: moc)
			newBusInformation.id = self.BusArray[i].id
			newBusInformation.busId = self.BusArray[i].busId
			newBusInformation.busDepartureTime = Int16(self.BusArray[i].busDepartureTime)
			newBusInformation.availableSeats = Int16(self.BusArray[i].availableSeats)
			newBusInformation.isAvailable = self.BusArray[i].isAvailable
			newBusInformation.checkIn = self.BusArray[i].checkIn
			newBusInformation.infoDate = self.BusArray[i].infoDate
			
			do {
				try moc.save()
				print("BusInformatino----CoreData------Success")
			}
			catch(let error) {
				print("Can't save on CoreData(BusInformation) \(error)")
			}
		}
		
		CKManager.shared.reset()
	}
	
	func manualAvailabilityCheck(arrivalTime: Int) {
		DispatchQueue.main.asyncAfter(deadline: .now()+2) { [weak self] in
			for i in 0..<(self?.BusArray.count ?? 0) {
				if(self?.BusArray[i].busDepartureTime ?? 0 < arrivalTime) {
					self?.BusArray[i].isAvailable = false
				}
				else {
					self?.BusArray[i].isAvailable = true
				}
			}
			self?.indicatorIsHidden = true
		}
	}
	
//	func autoSync() {
//		// 1. fetch()
//		// 2. if currentTime == anyBusDepartureTime
//		//      -> true: if passenger < 15
//		//                  -> true: busDepartureTime + 2, then update()
//		//                  -> false: isAvailable = false, then update()
//		//      -> false: continue
//
//
//		self.fetch()
//
//		for i in 0..<BusArray.count {
//			if(BusArray[i].busDepartureTime == DateManager.currentHourMinute()) {
//				if(BusArray[i].passengers.count < 15) {
//					BusArray[i].busDepartureTime += 2
//				}
//				else {
//					BusArray[i].isAvailable = false
//				}
//				CKManager.shared.update(recordID: BusArray[i].recordID!, newValues: BusArray[i].toDictionary()) { newRecord, error in
//					guard error == nil else {
//						print(error as Any)
//						return
//					}
//					print("success update")
//				}
//			}
//		}
//		self.indicatorIsHidden = true
//	}
}
