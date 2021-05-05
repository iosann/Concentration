//
//  Card.swift
//  Concentration
//
//  Created by Anna Belousova on 30.04.2021.
//

import Foundation

struct Card {
	var isFaceUp = false
	var isMatched = false
	let identifier: Int
	static var identifierFactory = 0

	init() {
		self.identifier = Card.getUniqueIdentifier()
	}

	static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
}