//
//  BusInfo.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import Foundation
import CloudKit

struct BusInfo: Hashable,Identifiable,Comparable {
	var id = UUID().uuidString
	var recordID : CKRecord.ID?
	var busId: String = "Bus"
	var busDepartureTime: Int = 720
	var availableSeats: Int = 50
	var isAvailable: Bool = true
	var checkIn: Bool = false
	var passengers: [String] = [String]()
	var infoDate: String = ""
	
	static func < (lhs: BusInfo, rhs: BusInfo) -> Bool {
		return lhs.busId < rhs.busId
	}
	
	
	func toDictionary() -> [String : Any] {
		return [
			"id" : id,
			"busId" : busId,
			"busDepartureTime" : busDepartureTime,
			"availableSeats" : availableSeats,
			"isAvailable" : isAvailable,
			"checkIn" : checkIn,
			"passengers" : passengers,
			"infoDate" : infoDate
		]
	}
}

struct Buses {
	static var buses: [BusInfo] = [
		BusInfo(
			busId: "Bus-A",
			busDepartureTime: 720,
			availableSeats: 50,
			isAvailable: false,
			checkIn: false,
			passengers: [String](),
			infoDate: DateManager.currentDate()
		),
		BusInfo(
			busId: "Bus-B",
			busDepartureTime: 730,
			availableSeats: 50,
			isAvailable: false,
			checkIn: false,
			passengers: [String](),
			infoDate: DateManager.currentDate()
		),
		BusInfo(
			busId: "Bus-C",
			busDepartureTime: 740,
			availableSeats: 50,
			isAvailable: false,
			checkIn: false,
			passengers: [String](),
			infoDate: DateManager.currentDate()
		),
		BusInfo(
			busId: "Bus-D",
			busDepartureTime: 750,
			availableSeats: 50,
			isAvailable: true,
			checkIn: false,
			passengers: [String](),
			infoDate: DateManager.currentDate()
		),
		BusInfo(
			busId: "Bus-E",
			busDepartureTime: 1353,
			availableSeats: 50,
			isAvailable: true,
			checkIn: false,
			passengers: [String](),
			infoDate: DateManager.currentDate()
		)
	]
}

//struct Buses {
//	static var buses: [BusInfo] = [
//		BusInfo(
//			busId: "Bus-A",
//			busDepartureTime: 720,
//			availableSeats: 35,
//			isAvailable: false,
//			checkIn: false,
//			passengers: ["Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C"]
//		),
//		BusInfo(
//			busId: "Bus-B",
//			busDepartureTime: 730,
//			availableSeats: 35,
//			isAvailable: false,
//			checkIn: false,
//			passengers: ["Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C"]
//		),
//		BusInfo(
//			busId: "Bus-C",
//			busDepartureTime: 740,
//			availableSeats: 47,
//			isAvailable: true,
//			checkIn: false,
//			passengers: ["Mr. D", "Mr. E", "Mr. F"]
//		),
//		BusInfo(
//			busId: "Bus-D",
//			busDepartureTime: 750,
//			availableSeats: 50,
//			isAvailable: true,
//			checkIn: false,
//			passengers: []
//		),
//		BusInfo(
//			busId: "Bus-E",
//			busDepartureTime: 805,
//			availableSeats: 50,
//			isAvailable: true,
//			checkIn: false,
//			passengers: []
//		)
//	]
//}
