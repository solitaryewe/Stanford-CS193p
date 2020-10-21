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
                Text(viewModel.gameTheme.name).font(.largeTitle)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("Score: \(viewModel.score)").font(.title3)
                Spacer()
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
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(5).opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
    }
}


// MARK: -
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
