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
    private(set) var score: Int = 0
    private var alreadySeenCards: [Int] = [Int]()
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set {
            // newValue is the value passed in.
            // Make all face down except this one.
            for index in cards.indices {
                if index != newValue && cards[index].isFaceUp && !cards[index].isMatched {
                    if !alreadySeenCards.contains(index) { alreadySeenCards.append(index) }
                }
                cards[index].isFaceUp = index == newValue
            }
            // Extra Credit 2: update timer to get the time when there is one card face up, because
            // we want the time measured to start when we flip the first card (of a possible match) over.
            timer = Date()
        }
    }
    // Extra Credit 2
    private var timer: Date = Date()
    
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
                // 1 face up card.
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Got a match.
                    // Task 8: keep score.
                    // Extra Credit 2: more points awarded for a faster match.
                    let secondsForMatch = Date().timeIntervalSince(timer)
                    score += max(10-Int(secondsForMatch), 2)

                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                } else {
                    // Mismatch.
                    // Task 8: keep score, -1 point per previously seen card in mismatch.
                    if alreadySeenCards.contains(potentialMatchIndex) { score -= 1 }
                    if alreadySeenCards.contains(chosenIndex) { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // 0 or more than 1 face up card.
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    
    // MARK: -
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
