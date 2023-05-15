//
//  Model.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import Foundation

class HomeVM: ObservableObject {
	
	@Published var BusArray: [BusInfo] = Buses.buses
	
}
