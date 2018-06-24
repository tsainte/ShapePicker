//
//  Position.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

typealias NormalizedCGFloat = CGFloat

struct Position {
    let relativeX: NormalizedCGFloat
    let relativeY: NormalizedCGFloat
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
