//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Woolly on 10/3/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

// ViewModel
class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        // A wider variety of emojis, shuffled for variety when picked.
        let emojis = ["👻", "🎃", "🕷", "🍬", "💀", "🦇", "🧹", "🍫"].shuffled()
        // Task 4: random number of cards between 2 and 5 pairs.
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Model Access
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card: card) }
}
