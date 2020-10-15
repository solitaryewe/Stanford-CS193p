//
//  MemoryGame.swift
//  Memorize
//
//  Created by Woolly on 10/3/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set {
            // newValue is the value passed in.
            // Make all face down except this one.
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            // Append two cards for the pair.
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        // Shuffling the cards, model's responsibility because it's part of how a MemoryGame plays.
        cards.shuffle()
    }
    
    // Args to functions are constant by default.
    // Card is a struct, which is a value type, which is copied every time.
    mutating func choose(_ card: Card) {
        // (Don't copy the card out - get its index and do it in the array.)
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            // , sequential &&
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Got a match.
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // 0 or more than one face up card.
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
