//
//  Command.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation

protocol Command {
    func execute()
}

protocol UndoableCommand: Command {
    func undo()
}
