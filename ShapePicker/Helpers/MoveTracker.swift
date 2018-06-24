//
//  MoveTracker.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class MoveTracker {
    private(set) var currentPosition: Position
    private(set) var lastPosition: Position

    init(from oldPosition: Position, to newPosition: Position) {
        self.currentPosition = newPosition
        self.lastPosition = oldPosition
    }
}
