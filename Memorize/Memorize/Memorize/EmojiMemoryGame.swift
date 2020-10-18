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
    // Task 4, 5: six different themes, add with one line of code.
    private let emojiMemoryGameThemes: [EmojiMemoryGameTheme] = [
        EmojiMemoryGameTheme(name: "Halloween", emojiSet: ["👻","🎃","🕷","🦇","🍭","🍬","🍫","🏴‍☠️","🕸","👀","💀","🧹"], primaryColor: Color.orange),
        EmojiMemoryGameTheme(name: "Birds", emojiSet: ["🦜","🦩","🦃","🦆","🦢","🦚","🐓"], primaryColor: Color.blue, numberOfPairs: 4),
        EmojiMemoryGameTheme(name: "Fairytale", emojiSet: ["🦄","🌷","🦕","🏰","👑","✨","🐸"], primaryColor: Color.purple, secondaryColor: Color.pink),
        EmojiMemoryGameTheme(name: "Farm Animals", emojiSet: ["🐄","🐖","🐐","🐓","🐇","🐑","🦃"], primaryColor: Color.green),
        EmojiMemoryGameTheme(name: "Space", emojiSet: ["👽","🚀","🛰","🛸","🌎","⭐️","🌞"], primaryColor: Color.gray, secondaryColor: Color.black, numberOfPairs: 5),
        EmojiMemoryGameTheme(name: "Fruit", emojiSet: ["🍊","🍉","🍒","🍓","🍐","🥝","🍌","🍇"], primaryColor: Color.red, numberOfPairs: 3)
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
    public func newGame() {
        gameTheme = emojiMemoryGameThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
    }
    
    // MARK: - Model Access
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) { model.choose(card) }
    
    // MARK: -
    // Task 3: theme
    // Extra Credit 1: gradient as the "color" for the theme.
    // Themes created with only a primaryColor will have a gradient that appears solid.
    struct EmojiMemoryGameTheme {
        var name: String
        var emojiSet: [String]
        private(set) var primaryColor: Color
        private(set) var secondaryColor: Color?
        var numberOfPairs: Int?
        
        var gradient: Gradient {
            Gradient(colors: [primaryColor, secondaryColor != nil ? secondaryColor! : primaryColor])
        }
        var accentColor: Color {
            primaryColor
        }
    }
}
