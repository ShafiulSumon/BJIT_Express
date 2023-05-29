//
//  View+Ext.swift
//  BJIT_Express
//
//  Created by ShafiulAlam-00058 on 5/22/23.
//

import Foundation
import SwiftUI

extension View {
	@ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
		if isHidden {
			self.hidden()
		}
		else {
			self
		}
	}
}
