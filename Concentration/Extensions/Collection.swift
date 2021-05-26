//
//  Collection.swift
//  Concentration
//
//  Created by Anna Belousova on 27.05.2021.
//

import Foundation

extension Collection {
	var oneAndOnly: Element? {
		return count == 1 ? first : nil
	}
}
