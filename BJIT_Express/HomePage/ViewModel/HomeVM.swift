//
//  Model.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/5/23.
//

import Foundation

class HomeVM: ObservableObject {
	@Published var dummyArray : [String] = ["Bus-A", "Bus-B", "Bus-C", "Bus-D"]
	
	@Published var BusArray: [BusInfo] = Buses.buses
}
