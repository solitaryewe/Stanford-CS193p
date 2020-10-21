//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Woolly on 10/3/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

// ViewModel
class EmojiMemoryGame: ObservableObject {
    // Publishing changes in this automatically (objectWillChange.send())
    @Published private var model: MemoryGame<String>
    private(set) var gameTheme: EmojiMemoryGameTheme
    private let emojiMemoryGameThemes: [EmojiMemoryGameTheme] = [
        EmojiMemoryGameTheme(name: "Halloween", emojiSet: ["👻","🎃","🕷","🦇","🍭","🍬","🍫","🏴‍☠️","🕸","👀","💀","🧹"], color: Color.orange),
        EmojiMemoryGameTheme(name: "Birds", emojiSet: ["🦜","🦩","🦃","🦆","🦢","🦚","🐓"], color: Color.blue, numberOfPairs: 4),
        EmojiMemoryGameTheme(name: "Fairytale", emojiSet: ["🦄","🌷","🦕","🏰","👑","✨","🐸"], color: Color.purple),
        EmojiMemoryGameTheme(name: "Farm Animals", emojiSet: ["🐄","🐖","🐐","🐓","🐇","🐑","🦃"], color: Color.green),
        EmojiMemoryGameTheme(name: "Space", emojiSet: ["👽","🚀","🛰","🛸","🌎","⭐️","🌞"], color: Color.gray, numberOfPairs: 5),
        EmojiMemoryGameTheme(name: "Fruit", emojiSet: ["🍊","🍉","🍒","🍓","🍐","🥝","🍌","🍇"], color: Color.red, numberOfPairs: 3)
    ]
    
    private static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
        // Task 2: shuffle cards.
        let emojis = theme.emojiSet.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairs != nil ? theme.numberOfPairs! : Int.random(in: 2...theme.emojiSet.count)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in emojis[pairIndex] }
    }
    
    init() {
        gameTheme = emojiMemoryGameThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
    
    // I don't like that this is a repeat of init(), but I'm not sure what to do about that at this point.
    func newGame() {
        gameTheme = emojiMemoryGameThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
    
    // MARK: - Model Access
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) { model.choose(card) }
    
    // MARK: -
    struct EmojiMemoryGameTheme {
        var name: String
        var emojiSet: [String]
        var color: Color
        var numberOfPairs: Int?
    }
}
