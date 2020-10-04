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
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Model Access
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) { model.choose(card: card) }
}
