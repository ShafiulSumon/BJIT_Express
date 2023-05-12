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
	
    var body: some View {
		if employee.isEmpty {
			StartingView()
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
