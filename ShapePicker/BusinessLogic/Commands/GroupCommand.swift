//
//  GroupCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation
class GroupCommand: UndoableCommand {

    let commands: [UndoableCommand]
    init(commands: [UndoableCommand]) {
        self.commands = commands
    }

    func execute() {
        commands.forEach { $0.execute() }
    }
    
    func undo() {
        commands.forEach { $0.undo() }
    }
}
