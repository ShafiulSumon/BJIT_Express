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
}
