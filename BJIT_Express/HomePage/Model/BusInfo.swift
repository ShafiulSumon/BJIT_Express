//
//  BusInfo.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import Foundation

struct BusInfo: Hashable {
	var busId: String = "Bus"
	var busDepartureTime: Int = 720
	var availableSeats: Int = 50
	var isAvailable: Bool = true
	var checkIn: Bool = false
	var passengers: [String] = []
}

struct Buses {
	static var buses: [BusInfo] = [
		BusInfo(
			busId: "Bus-A",
			busDepartureTime: 720,
			availableSeats: 35,
			isAvailable: false,
			checkIn: false,
			passengers: ["Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C"]
		),
		BusInfo(
			busId: "Bus-B",
			busDepartureTime: 730,
			availableSeats: 35,
			isAvailable: false,
			checkIn: false,
			passengers: ["Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C", "Mr. A", "Mr. B", "Mr. C"]
		),
		BusInfo(
			busId: "Bus-C",
			busDepartureTime: 740,
			availableSeats: 47,
			isAvailable: true,
			checkIn: false,
			passengers: ["Mr. D", "Mr. E", "Mr. F"]
		),
		BusInfo(
			busId: "Bus-D",
			busDepartureTime: 750,
			availableSeats: 50,
			isAvailable: true,
			checkIn: false,
			passengers: []
		),
		BusInfo(
			busId: "Bus-E",
			busDepartureTime: 805,
			availableSeats: 50,
			isAvailable: true,
			checkIn: false,
			passengers: []
		)
	]
}
