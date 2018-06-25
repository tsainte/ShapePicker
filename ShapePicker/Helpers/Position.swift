//
//  Position.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

// We're explicity redefining CGFloat to be clear to the user of this API that the value should be normalized.
// Normalized values are always between 0-1.
typealias NormalizedCGFloat = CGFloat

struct Position {
    let relativeX: NormalizedCGFloat
    let relativeY: NormalizedCGFloat
}

extension Position: Equatable {
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.relativeX == rhs.relativeX && lhs.relativeY == rhs.relativeY
    }
}

extension Position {
    func pointExtended(by size: CGSize) -> CGPoint {
        return CGPoint(x: relativeX * size.width,
                       y: relativeY * size.height)
    }
}

extension CGPoint {
    func positionNormalized(by size: CGSize) -> Position {
        return Position(relativeX: x / size.width,
                        relativeY: y / size.height)
    }
}
