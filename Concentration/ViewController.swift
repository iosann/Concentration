//
//  ViewController.swift
//  Concentration
//
//  Created by Anna Belousova on 28.04.2021.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet private var buttons: [UIButton]!
	@IBOutlet private var flipCountLabel: UILabel!
	@IBOutlet private var scoreLabel: UILabel!
	@IBOutlet private var newGameButton: UIButton!
	
	private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	private var numberOfPairsOfCards: Int {
		return (buttons.count + 1)/2
	}
	private var darkColor = UIColor()
	private var lightColor = UIColor()
	private var themeArray = [["emojis": ["🐒", "🦩", "🐁", "🐋", "🐍", "🐶", "🐼", "🦊"], "lightColor": #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), "darkColor": #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)], ["emojis": ["😄", "😭", "😡", "😳", "😱", "😍", "😘", "😜"], "lightColor": #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), "darkColor": #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)], ["emojis": ["🥶", "⛸", "🏂", "☃️", "❄️", "🧊", "⛷", "🌄"], "lightColor": #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), "darkColor": #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]]
	private var emojiArray = [String]()
	private var usedEmojisDict = [Int: String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		chooseAndSetTheme()
		updateUI()
	}

	private func chooseAndSetTheme() {
		guard let currentTheme = themeArray.randomElement() else { return }
		emojiArray = currentTheme["emojis"] as? [String] ?? []
		lightColor = currentTheme["lightColor"] as? UIColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		darkColor = currentTheme["darkColor"] as? UIColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
	}

	private func updateUI() {
		view.backgroundColor = lightColor
		newGameButton.backgroundColor = darkColor
		newGameButton.setTitleColor(lightColor, for: .normal)
		newGameButton.layer.cornerRadius = 10
		flipCountLabel.textColor = darkColor
		scoreLabel.textColor = darkColor

		for button in buttons {
			button.backgroundColor = darkColor
			button.setTitle("", for: .normal)
			button.layer.cornerRadius = 10
		}
	}

	@IBAction private func touchCard(_ sender: UIButton) {
		guard let cardNumber = buttons.firstIndex(of: sender) else { return }
		let flipAndScore =	game.chooseCard(at: cardNumber)
		flipCountLabel.text = "Flips: \(flipAndScore.flipCount)"
		scoreLabel.text = "Score: \(flipAndScore.score)"
		updateViewFromModel()
	}

	private func updateViewFromModel() {
		for index in buttons.indices {
			let button = buttons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				button.setTitle(appointEmoji(for: card), for: .normal)
			} else {
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : darkColor
				button.setTitle("", for: .normal)
			}
		}
	}

	private func appointEmoji(for card: Card) -> String {
		if usedEmojisDict[card.identifier] == nil, emojiArray.count > 0 {
			let randomIndex = emojiArray.count.arc4random
			usedEmojisDict[card.identifier] = emojiArray.remove(at: randomIndex)
		}
		return usedEmojisDict[card.identifier] ?? "?"
	}

	@IBAction private func startNewGame(_ sender: UIButton) {
		game = Concentration(numberOfPairsOfCards: (buttons.count + 1)/2)
		flipCountLabel.text = "Flips: 0"
		scoreLabel.text = "Score: 0"
		chooseAndSetTheme()
		updateUI()
	}
}
