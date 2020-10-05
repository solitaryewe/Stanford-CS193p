//
//  ContentView.swift
//  Memorize
//
//  Created by Woolly on 10/2/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

// View
struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {    // spacing: between individual stacked views
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture { viewModel.choose(card: card) }
            }
            // Task 3: aspect ratio applied to each CardView.
            // Chose to put it here rather than making it a part of the returned
            // CardView because another use of CardView require a different aspect ratio.
            .aspectRatio(2/3, contentMode: .fit)
        }
        .padding()
        .foregroundColor(Color.orange)
        // Task 5: choose larger font for less than 5 pairs of cards, smaller otherwise.
        .font(viewModel.cards.count / 2 < 5 ? .largeTitle : .title)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
