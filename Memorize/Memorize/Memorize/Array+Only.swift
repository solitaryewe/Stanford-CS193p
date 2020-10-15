//
//  Array+Only.swift
//  Memorize
//
//  Created by Woolly on 10/15/20.
//  Copyright © 2020 The Woolly Co. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil    // self.count
    }
}
