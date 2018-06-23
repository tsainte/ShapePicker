//
//  MoveShapeCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation
protocol MoveExecutable: class {
    func performMove(to: Position)
}

class MoveShapeCommand: UndoableCommand {
    let tracker: MoveTracker
    weak var shape: Plottable?
    weak var delegate: MoveExecutable?

    init(tracker: MoveTracker, shape: Plottable, delegate: MoveExecutable) {
        self.tracker = tracker
        self.delegate = delegate
    }

    func execute() {
//        delegate?.performMove()
    }
    
    func undo() {
        delegate?.performMove(to: tracker.lastPosition)
    }
}
