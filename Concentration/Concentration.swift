//
//  Concentration.swift
//  Concentration
//
//  Created by Anna Belousova on 30.04.2021.
//

import Foundation

class Concentration {

	var cards = [Card]()
	var indexOfOneAndOnlyFaceUpCard: Int?
	var flipCount = 0
	var score = 0
	var indicesOfOpenedCards = [Int]()

	init(numberOfPairsOfCards: Int) {
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		cards.shuffle()
		flipCount = 0
		score = 0
	}

	func chooseCard(at index: Int) -> [Int] {
		flipCount += 1
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
					score += 2
					indicesOfOpenedCards.removeLast()
				} else {
					if indicesOfOpenedCards.contains(index) { score -= 1 }
					indicesOfOpenedCards.append(index)
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = nil
			} else {
				for flipdownIndex in cards.indices {
					cards[flipdownIndex].isFaceUp = false
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = index
				indicesOfOpenedCards.append(index)
			}
		}
		return [flipCount, score]
	}
}
