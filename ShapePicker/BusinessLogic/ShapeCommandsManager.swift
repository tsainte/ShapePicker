//
//  ShapeCommandsManager.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

typealias NormalizedCGFloat = CGFloat

struct Position {
    let relativeX: NormalizedCGFloat
    let relativeY: NormalizedCGFloat
}

protocol Plottable: class {
    var position: Position { get }
}

typealias CommandExecutable = AddRemoveExecutable & MoveExecutable
class ShapeCommandsManager {
    var commands: [UndoableCommand] = []
    weak var commandsExecutable: CommandExecutable?

    init(commandsExecutable: CommandExecutable) {
        self.commandsExecutable = commandsExecutable
    }
}

//MARK: Actions
extension ShapeCommandsManager {
    func add(_ shape: Plottable) {
        guard let delegate = commandsExecutable else { return }

        let addCommand = AddShapeCommand(delegate: delegate, shape: shape)
        addCommand.execute()
        commands.append(addCommand)
    }

    func remove(_ shape: Plottable) {
        guard let delegate = commandsExecutable else { return }

        let removeCommand = RemoveShapeCommand(delegate: delegate, shape: shape)
        removeCommand.execute()
        commands.append(removeCommand)
    }

    func move(_ shape: Plottable,
              from oldPosition: Position,
              to newPosition: Position) {
        guard let delegate = commandsExecutable else { return }

        let tracker = MoveTracker(from: oldPosition, to: newPosition)

        let moveCommand = MoveShapeCommand(tracker: tracker, shape: shape, delegate: delegate)
        moveCommand.execute()
        commands.append(moveCommand)
    }

    func undo() {
        guard let lastCommand = commands.last else { return }
        lastCommand.undo()
        commands.removeLast()
    }
}
