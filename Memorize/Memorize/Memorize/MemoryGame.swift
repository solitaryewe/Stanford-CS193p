//
//  MemoryGame.swift
//  Memorize
//
//  Created by Woolly on 10/3/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            // Append two cards for the pair.
            cards.append(Card(id: pairIndex*2, isFaceUp: true, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: true, content: content))
        }
        // Task 2: shuffling the cards, model's responsibility because it's part of how a MemoryGame plays.
        cards.shuffle()
    }
    
    func choose(card: Card) {
        print("Card chosen: \(card)")
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
