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
        }
        .padding()  // around the entire HStack
        .foregroundColor(Color.orange)  // passed on to children
        .font(Font.largeTitle)
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
