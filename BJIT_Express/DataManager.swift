//
//  DataManager.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
	let container = NSPersistentContainer(name: "BJIT_Express")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Loading CoreData is failed!")
			}
		}
	}
}
