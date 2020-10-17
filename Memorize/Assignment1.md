# Memorize: *Assignment 1*
The complete code for this assignment can be found [here](https://github.com/solitaryewe/Stanford-CS193p/tree/3c0bd94defb19fa6c9fb503463858426beaff50c/Memorize/Memorize).

![Memorize: Assignment 1](https://github.com/solitaryewe/Stanford-CS193p/blob/main/Memorize/Screenshots/Assignment1a.png)![Memorize: Assignment 1](https://github.com/solitaryewe/Stanford-CS193p/blob/main/Memorize/Screenshots/Assignment1b.png)

## Task 1
> Get the Memorize game working as demonstrated in lectures 1 and 2.  Type in all the code.  Do not copy/paste from anywhere.

✔️

## Task 2
> Currently the cards appear in a predictable order (the matches are always side-by-side, making the game very easy).  Shuffle the cards.

```swift
// EmojiMemoryGame.swift
let emojis = ["👻", "🎃", "🕷", "🍬", "💀", "🦇", "🧹", "🍫"].shuffled()
```

## Task 3
> Our cards are currently arranged in a single row (we’ll fix that next week).  That’s making our cards really tall and skinny (especially in portrait) which doesn’t look very good.  Force each card to have a width to height ratio of  2:3 (this will result in empty space above and/or below your cards, which is fine).

Used the *.aspectRatio() modifier*:

```swift
// ContentView.swift
ForEach(viewModel.cards) { card in
    CardView(card: card).onTapGesture { viewModel.choose(card: card) }
}.aspectRatio(2/3, contentMode: .fit)
```

## Task 4
> Have your game start up with a random number of  pairs of  cards between 2 pairs and 5 pairs.

```swift
// EmojiMemoryGame.swift
static func createMemoryGame() -> MemoryGame<String> {
    let emojis = ["👻", "🎃", "🕷", "🍬", "💀", "🦇", "🧹", "🍫"].shuffled()
    return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
        emojis[pairIndex]
    }
}
```

## Task 5
> When your game randomly shows 5 pairs, the font we are using for the emoji will be too large (in portrait) and will start to get clipped.  Have the font adjust in the 5 pair case (only) to use a smaller font than .largeTitle.  Continue to use .largeTitlewhen there are 4 or fewer pairs in the game.

Used the *ternary operator* in the *.font() modifier* to adjust the font size based on how many cards are in the game:

```swift
// ContentView.swift
var body: some View {
    HStack {
        ForEach(viewModel.cards) { card in
            CardView(card: card).onTapGesture { viewModel.choose(card: card) }
        }.aspectRatio(2/3, contentMode: .fit)
    }
    .padding()
    .foregroundColor(Color.orange)
    .font(viewModel.cards.count / 2 < 5 ? .largeTitle : .title)
}
```

## Task 6
> Your UI should work in portrait or landscape on any iOS device.  In landscape your cards will be larger (but still 2:3 aspect ratio).  This probably will not require any work on your part (that’s part of  the power of  SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure.

✔️

## Extra Credit 1

> Have the emoji on your cards be randomly chosen from a larger set of emoji (at least a dozen).  In other words, don’t always use the same five emoji in every game.

Couldn't find 12 halloween emojis, but same idea: shuffle a larger emoji set before the first x are selected.  This will yield a different subset each time.

```swift
// EmojiMemoryGame.Swift
static func createMemoryGame() -> MemoryGame<String> {
    let emojis = ["👻", "🎃", "🕷", "🍬", "💀", "🦇", "🧹", "🍫"].shuffled()
    return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
        emojis[pairIndex]
    }
}
```
