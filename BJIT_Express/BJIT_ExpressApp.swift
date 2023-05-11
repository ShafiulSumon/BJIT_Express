//
//  BJIT_ExpressApp.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/3/23.
//

import SwiftUI

@main
struct BJIT_ExpressApp: App {

	@StateObject var persistenceController = PersistenceController()
	
    var body: some Scene {
        WindowGroup {
			MotherView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
