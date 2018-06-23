//
//  RemoveShapeCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation
class RemoveShapeCommand: UndoableCommand {
    weak var delegate: AddRemoveExecutable?
    let shape: Plottable

    init(delegate: AddRemoveExecutable, shape: Plottable) {
        self.delegate = delegate
        self.shape = shape
    }
    func execute() {
        delegate?.performRemove(shape)
    }
    func undo() {
        delegate?.performAdd(shape)
    }
}
