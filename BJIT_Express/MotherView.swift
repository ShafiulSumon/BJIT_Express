//
//  MotherView.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/11/23.
//

import SwiftUI

struct MotherView: View {
	
	@Environment(\.managedObjectContext) private var moc
	@FetchRequest(sortDescriptors: []) private var employee: FetchedResults<ExpressTable>
	
	init() {
		if UserDefaults.standard.bool(forKey: UDKey.global_check_in.rawValue) == nil {
			UserDefaults.standard.set(false, forKey: UDKey.global_check_in.rawValue)
		}
		if UserDefaults.standard.string(forKey: UDKey.my_allocated_bus.rawValue) == nil {
			UserDefaults.standard.set("", forKey: UDKey.my_allocated_bus.rawValue)
		}
	}
	
    var body: some View {
		if employee.isEmpty {
			OnboardingView()
		}
		else {
			HomeView()
		}
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
