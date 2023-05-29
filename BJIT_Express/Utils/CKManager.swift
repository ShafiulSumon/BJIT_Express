//
//  CKManager.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/22/23.
//

import Foundation
import CloudKit


class CKManager: NSObject, ObservableObject {
	
	static let shared = CKManager(container: CKContainer(identifier: "iCloud.IBY.bjitgroup.upskilldev"))
	
	private var container: CKContainer
	private var database: CKDatabase
	private var BusArray: [BusInfo] = []
	
	private init(container: CKContainer) {
		self.container = container
		self.database = container.publicCloudDatabase
	}
	
	func save(busInfo: BusInfo, completion: @escaping (BusInfo?) -> Void ) {
		let record = CKRecord(recordType: BusRecordType.busRecordType.rawValue)
		record.setValuesForKeys(busInfo.toDictionary())
		
		self.database.save(record) { newRecord, error in
			if let _ = error {
				print("Error due to saving data in CK: \(String(describing: error?.localizedDescription))")
			}
			if let _ = newRecord {
				print("Data save successfully!")
				completion(busInfo)
			}
		}
	}
	
	
	
	func fetch(completion: @escaping ([BusInfo]) -> Void ) {
		
		let query = CKQuery(recordType: BusRecordType.busRecordType.rawValue, predicate: NSPredicate(value: true))
		database.fetch(withQuery: query) { [weak self] result in
			switch result {
			case .success(let matchResults):
				self?.BusArray = []
				matchResults.matchResults.compactMap({$0.1})
					.forEach {
						switch $0 {
						case .success(let record):
							if let busInfo = self?.fromRecord(record) {
								//completion(busInfo)
								//busInfo.recordID = record.recordID
								//print(record.recordID)
								let _busInfo = BusInfo(id: busInfo.id, recordID: record.recordID, busId: busInfo.busId, busDepartureTime: busInfo.busDepartureTime, availableSeats: busInfo.availableSeats, isAvailable: busInfo.isAvailable, checkIn: busInfo.checkIn, passengers: busInfo.passengers, infoDate: busInfo.infoDate)
								self?.BusArray.append(_busInfo)
//								self?.BusArray.last?.recordID = record.recordID
							}
						case .failure(let error):
							print(error)
							completion([])
						}
					}
				completion(self?.BusArray ?? [])
			case .failure(let error):
				print(error)
				completion([])
			}
		}
	}
	
	func reset() {
		let query = CKQuery(recordType: BusRecordType.busRecordType.rawValue, predicate: NSPredicate(value: true))
		
		self.database.perform(query, inZoneWith: nil) { records, error in
			if let error = error {
				print("Failed to fetch records for deletion: \(error)")
				return
			}

			guard let records = records else {
				print("No records found for deletion")
				return
			}

			let deleteOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: records.map { $0.recordID })
			
			deleteOperation.modifyRecordsCompletionBlock = { (_, _, error) in
				if let error = error {
					print("Failed to delete records: \(error)")
				} else {
					print("All records deleted successfully")
				}
			}
			self.database.add(deleteOperation)
		}
	}
	
	func update(recordID: CKRecord.ID, newValues: [String: Any], completion: @escaping (CKRecord?, Error?) -> Void) {
		self.database.fetch(withRecordID: recordID) { record, error in
			if let error = error {
				print("Failed to fetch record for update: \(error)")
				completion(nil, error)
				return
			}
			
			guard let record = record else {
				print("Record not found for update")
				completion(nil, nil)
				return
			}
			
			record.setValuesForKeys(newValues)
			
			self.database.save(record) { updatedRecord, error in
				if let error = error {
					print("Failed to update record: \(error)")
					completion(nil, error)
				} else {
					print("Record updated successfully")
					completion(updatedRecord, nil)
				}
			}
		}
	}

	
	func delete(_ recordId: CKRecord.ID, completion: @escaping (Error?) -> Void) {
		
		database.delete(withRecordID: recordId) { _, error in
			guard error == nil else {
				completion(error)
				return
			}
			completion(nil)
		}
		
	}

	
	
	
	func fromRecord(_ record: CKRecord) -> BusInfo? {
		guard let busId = record.value(forKey: "busId") as? String,
			  let busDepartureTime = record.value(forKey: "busDepartureTime") as? Int,
			  let availableSeats = record.value(forKey: "availableSeats") as? Int,
			  let isAvailable = record.value(forKey: "isAvailable") as? Bool,
			  let checkIn = record.value(forKey: "checkIn") as? Bool,
			  let passengers = record.value(forKey: "passengers") as? [String] else {
			return nil
		}
		return BusInfo(
			busId: busId,
			busDepartureTime: busDepartureTime,
			availableSeats: availableSeats,
			isAvailable: isAvailable,
			checkIn: checkIn,
			passengers: passengers
		)
	}
}
