//
//  PersistenceController.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import Foundation
import CoreData

class PersistenceController: ObservableObject {
	let container = NSPersistentContainer(name: "BJIT_Express")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("CoreData Loading Failed!. Error: \(error)")
			}
		}
	}
}
