# Memorize: *Assignment 2*

![Memorize: Assignment 2](https://github.com/solitaryewe/Stanford-CS193p/blob/main/Memorize/Screenshots/Assignment2a.png)

## Task 1
> Get the Memorize game working as demonstrated in lectures 1 through 4.  Type in all the code.  Do not copy/paste from anywhere.

✔️

## Task 2
> Your game should still shuffle the cards.

```swift
// EmojiMemoryGame.swift
private static func createMemoryGame(theme: EmojiMemoryGameTheme) -> MemoryGame<String> {
    let emojis = theme.emojiSet.shuffled()
    let numberOfPairsOfCards = theme.numberOfPairs != nil ? theme.numberOfPairs! : Int.random(in: 2...theme.emojiSet.count)
    return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in emojis[pairIndex] }
}
```

## Task 3
> Architect the concept of  a “theme” into your game.  A theme consists of  a name for the theme, a set of  emoji to use, a number of  cards to show (which, for at least one, but not all themes, should be random), and an appropriate color to use to draw (e.g. orange would be appropriate for a Halloween theme).

```swift
// EmojiMemoryGame.swift
struct EmojiMemoryGameTheme {
    var name: String
    var emojiSet: [String]
    var color: Color
    var numberOfPairs: Int?
}
```

## Task 4
> Support at least 6 different themes in your game.

```swift
// EmojiMemoryGame.swift
private let emojiMemoryGameThemes: [EmojiMemoryGameTheme] = [
    EmojiMemoryGameTheme(name: "Halloween", emojiSet: ["👻","🎃","🕷","🦇","🍭","🍬","🍫","🏴‍☠️","🕸","👀","💀","🧹"], color: Color.orange),
    EmojiMemoryGameTheme(name: "Birds", emojiSet: ["🦜","🦩","🦃","🦆","🦢","🦚","🐓"], color: Color.blue, numberOfPairs: 4),
    EmojiMemoryGameTheme(name: "Fairytale", emojiSet: ["🦄","🌷","🦕","🏰","👑","✨","🐸"], color: Color.purple),
    EmojiMemoryGameTheme(name: "Farm Animals", emojiSet: ["🐄","🐖","🐐","🐓","🐇","🐑","🦃"], color: Color.green),
    EmojiMemoryGameTheme(name: "Space", emojiSet: ["👽","🚀","🛰","🛸","🌎","⭐️","🌞"], color: Color.gray, numberOfPairs: 5),
    EmojiMemoryGameTheme(name: "Fruit", emojiSet: ["🍊","🍉","🍒","🍓","🍐","🥝","🍌","🍇"], color: Color.red, numberOfPairs: 3)
]
```

## Task 5
> A new theme should be able to be added to your game with a single line of code.

See above.

## Task 6
> Add a “New Game” button to your UI which begins a brand new game.  This new game should have a randomly chosen theme.  You can put this button anywhere you think looks best in your UI.

```swift
// EmojiMemoryGameView.swift
Button(action: { viewModel.newGame() }) {
    Text("New Game").font(.title3).bold()
}
```

```swift
// EmojiMemoryGame.swift
public func newGame() {
    gameTheme = emojiMemoryGameThemes.randomElement()!
    model = EmojiMemoryGame.createMemoryGame(theme: gameTheme)
}
```

## Task 7
> Show the theme’s name somewhere in your UI.

```swift
// EmojiMemoryGame.swift
Text(viewModel.gameTheme.name).font(.largeTitle)
```

## Task 8
> Keep score in your game by giving 2 points for every match and penalizing 1 point for every previously seen card that is involved in a mismatch.

Add cards we've seen to the alreadySeenCards array:
```swift
// MemoryGame.swift
private var alreadySeenCards: [Int] = [Int]()
var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { index in cards[index].isFaceUp }.only }
    set {
        for index in cards.indices {
            if index != newValue && cards[index].isFaceUp && !cards[index].isMatched {
                if !alreadySeenCards.contains(index) { alreadySeenCards.append(index) }
            }
            cards[index].isFaceUp = index == newValue
        }
    }
}
```

When attempting to make a match, check if we've seen the cards in the attempted match before and adjust score accordingly:
```swift
// MemoryGame.swift
mutating func choose(_ card: Card) {
    if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                // Got a match.
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                score += 2
            } else {
                // Mismatch.
                if alreadySeenCards.contains(potentialMatchIndex) { score -= 1 }
                if alreadySeenCards.contains(chosenIndex) { score -= 1 }
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }
}
```

## Task 9
> Display the score in your UI in whatever way you think looks best.

```swift
// EmojiMemoryGame.swift
Text("Score: \(viewModel.score)").font(.title3)
```

## Task 10
> Your UI should work in portrait or landscape on any iOS device.  The cards can have any aspect ratio you’d like.  This probably will not require any work on your part (that’s part of  the power of  SwiftUI), but be sure to continue to experiment with running on different simulators in Xcode to be sure.

✔️
