//
//  DateManager.swift
//  BJIT_Express
//
//  Created by Shafiul on 5/21/23.
//

import Foundation

final class DateManager {
    static func makeArrivalTime(hour: Int, minute: Int) -> String {
        var _hour = hour
        if(hour/12 > 0) {
			_hour = (hour%12 == 0) ? 12 : (hour%12)
        }
        let timeString = "\(_hour):" + String(format: "%02d", minute) + (hour/12 > 0 ? " PM" : " AM")
        return timeString
    }
	
	static func currentDate() -> String {
		let currentDate = Date()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"  // Format for day, month, and year
		
		return dateFormatter.string(from: currentDate)
	}
	
	static func currentHourMinute() -> Int {
		let currentDate = Date()
		
		let hour = Calendar.current.component(.hour, from: currentDate)
		let minute = Calendar.current.component(.minute, from: currentDate)
		
		return ((hour*100) + minute)
	}
}
