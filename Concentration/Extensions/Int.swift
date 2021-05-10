//
//  Int.swift
//  Concentration
//
//  Created by Anna Belousova on 09.05.2021.
//

import Foundation

extension Int {
	var arc4random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(-self)))
		} else {
			return 0
		}
	}
}
