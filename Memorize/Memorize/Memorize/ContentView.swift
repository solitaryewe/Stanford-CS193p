//
//  ContentView.swift
//  Memorize
//
//  Created by Woolly on 10/2/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HStack {    // spacing: between individual stacked views
            ForEach(0..<4) { index in
                CardView(isFaceUp: true)
            }
        }
        .padding()  // around the entire HStack
        .foregroundColor(Color.orange)  // passed on to children
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
