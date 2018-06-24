//
//  MoveShapeCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation
protocol MoveExecutable: class {
    func performMove(on shape: PlottableView, to newPosition: Position)
}

class MoveShapeCommand: UndoableCommand {
    let tracker: MoveTracker
    weak var shape: PlottableView?
    weak var delegate: MoveExecutable?

    init(tracker: MoveTracker, shape: PlottableView, delegate: MoveExecutable) {
        self.tracker = tracker
        self.delegate = delegate
        self.shape = shape
    }

    // Since the user is executing the command with the recogniser, no need to implement it.
    // Could be used for the `redo` functionality
    func execute() { }

    func undo() {
        guard let shape = shape else { return }
        delegate?.performMove(on: shape, to: tracker.lastPosition)
    }
}
