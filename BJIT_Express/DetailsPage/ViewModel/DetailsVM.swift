//
//  DetailsVM.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/8/23.
//

import Foundation
import CloudKit

class DetailsVM: ObservableObject {
	
	func update(busInfo: BusInfo) {
		
		CKManager.shared.update(recordID: busInfo.recordID!, newValues: busInfo.toDictionary()) { newRecord, error in
			guard error == nil else {
				print(error as Any)
				return
			}
			print("success update")
		}
	}
	
}
