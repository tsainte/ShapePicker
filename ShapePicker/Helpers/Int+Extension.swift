//
//  Int+Extension.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation
extension Int {
    static func random(_ range:Range<Int>) -> Int {
        let deltaRange = range.upperBound - range.lowerBound
        return range.lowerBound + Int(arc4random_uniform(UInt32(deltaRange)))
    }
}
