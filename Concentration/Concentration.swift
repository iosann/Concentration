//
//  Concentration.swift
//  Concentration
//
//  Created by Anna Belousova on 30.04.2021.
//

import Foundation

class Concentration {

	private enum Points: Int {
		case bonus = 2
		case fine = -1
	}

	private (set) var cards = [Card]()
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil { foundIndex = index } else { return nil }
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	private var flipCount = 0
	private var score = 0
	private var indicesOfOpenedCards = [Int]()

	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): you must have at least one pair of cards")
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		cards.shuffle()
		flipCount = 0
		score = 0
	}

	func chooseCard(at index: Int) -> (flipCount: Int, score: Int) {
		flipCount += 1
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)), choosen index not in the cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
					score += Points.bonus.rawValue
					indicesOfOpenedCards.removeLast()
				} else {
					if indicesOfOpenedCards.contains(index) { score += Points.fine.rawValue }
					indicesOfOpenedCards.append(index)
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
				indicesOfOpenedCards.append(index)
			}
		}
		return (flipCount, score)
	}
}
