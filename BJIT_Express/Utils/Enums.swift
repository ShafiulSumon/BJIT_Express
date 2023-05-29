//
//  Enums.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/23/23.
//

import Foundation

enum ButtonStatus: String {
	case checkIn = "Check-In"
	case checkOut = "Check-Out"
	case unavailable = "X"
}

enum UDKey: String {
	case global_check_in = "global_check_in"
	case my_allocated_bus = "my_allocated_bus"
	case buttonActive = "buttonActive"
}

enum BusRecordType: String {
	case busRecordType = "busRecordType"
}
