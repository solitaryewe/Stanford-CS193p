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
        // Shuffling the cards, model's responsibility because it's part of how a MemoryGame plays.
        cards.shuffle()
    }
    
    // Args to functions are constant by default.
    // Card is a struct, which is a value type, which is copied every time.
    mutating func choose(_ card: Card) {
        print("Card chosen: \(card)")
        // Have to find the card in the cards array, then toggle isFaceUp on that one.
        // (Don't copy the card out - do it in the array.)
        let chosenIndex: Int = index(of: card)!
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    // Get index of a Card in the cards array.
    private func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id { return index }
        }
        return nil
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
