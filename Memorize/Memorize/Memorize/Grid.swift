//
//  Grid.swift
//  Memorize
//
//  Created by Woolly on 10/14/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: items.firstIndex(matching: item)!))
                    // Force unwrapped the index because it should never not be there.
            }
        }
    }
}


// MARK: - Preview of Grid

struct Grid_Previews: PreviewProvider {
    private static let fruitEmojis = ["🍊", "🍉", "🍒", "🍓", "🍐", "🥝", "🍌", "🍇"].shuffled()
    private static var items = buildFruit()
    private static func buildFruit() -> [Fruit] {
        var items = [Fruit]()
        for emoji in fruitEmojis {
            items.append(Fruit(yum: emoji))
        }
        return items
    }
    
    static var previews: some View {
        Grid(items) { fruit in
            Text(fruit.yum)
        }
    }
    
    private struct Fruit: Identifiable {
        var id = UUID()
        var yum: String
    }
}
