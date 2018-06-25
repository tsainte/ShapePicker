//
//  ShapeCommandsManager.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation

typealias CommandExecutable = AddRemoveExecutable & MoveExecutable

class ShapeCommandsManager {

    var commands: [UndoableCommand] = []
    weak var commandsExecutable: CommandExecutable?

    init(commandsExecutable: CommandExecutable) {
        self.commandsExecutable = commandsExecutable
    }
}

// MARK: Actions
extension ShapeCommandsManager {

    func add(_ plottableView: PlottableView) {
        guard let delegate = commandsExecutable else { return }

        let addCommand = AddShapeCommand(delegate: delegate, plottableView: plottableView)
        addCommand.execute()
        commands.append(addCommand)
    }

    func remove(_ plottableView: PlottableView) {
        guard let delegate = commandsExecutable else { return }

        let removeCommand = RemoveShapeCommand(delegate: delegate, plottableView: plottableView)
        removeCommand.execute()
        commands.append(removeCommand)
    }

    func removeAll(_ plottableViews: [PlottableView]) {
        guard let delegate = commandsExecutable else { return }
        let removeCommands = plottableViews.map { return RemoveShapeCommand(delegate: delegate,
                                                                            plottableView: $0) }
        let removeGroupCommand = GroupCommand(commands: removeCommands)
        removeGroupCommand.execute()
        commands.append(removeGroupCommand)
    }

    func move(_ plottableView: PlottableView,
              from oldPosition: Position,
              to newPosition: Position) {
        guard let delegate = commandsExecutable else { return }

        let tracker = MoveTracker(from: oldPosition, to: newPosition)

        let moveCommand = MoveShapeCommand(tracker: tracker, plottableView: plottableView, delegate: delegate)
        moveCommand.execute()
        commands.append(moveCommand)
    }

    func undo() {
        guard let lastCommand = commands.last else { return }
        lastCommand.undo()
        commands.removeLast()
    }
}
