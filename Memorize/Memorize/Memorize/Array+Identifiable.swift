//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Woolly on 10/14/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    // Get first index of an element in an array of identifiable elements.
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<count {    // self.count
            if self[index].id == matching.id { return index }
        }
        return nil
    }
}
