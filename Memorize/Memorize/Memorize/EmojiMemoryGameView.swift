//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Woolly on 10/2/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

// View
struct EmojiMemoryGameView: View {
    // Watching for published changes from this object.
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                // Task 7: theme name.
                Text(viewModel.gameTheme.name).font(.largeTitle)
            }
            .padding(.vertical, 5)
            
            HStack {
                // Task 9: display score.
                Text("Score: \(viewModel.score)").font(.title3)
                Spacer()
                // Task 6: new game button.
                Button(action: { viewModel.newGame() }) {
                    Text("New Game")
                        .font(.title3)
                        .bold()
                }
            }
            .padding(.horizontal)
            
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture { viewModel.choose(card: card) }
                    .padding(5)
            }
            .padding()
            .foregroundColor(viewModel.gameTheme.color)
        }
    }
}

// MARK: -
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).fill()
                    }
                }
            }
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // CardView Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


// MARK: -
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
    }
}
