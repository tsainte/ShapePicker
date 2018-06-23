//
//  AddCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation

protocol AddRemoveExecutable: class {
    func performAdd(_ shape: Plottable)
    func performRemove(_ shape: Plottable)
}

class AddShapeCommand: UndoableCommand {
    weak var delegate: AddRemoveExecutable?
    let shape: Plottable

    init(delegate: AddRemoveExecutable, shape: Plottable) {
        self.delegate = delegate
        self.shape = shape
    }
    func execute() {
        delegate?.performAdd(shape)
    }
    func undo() {
        delegate?.performRemove(shape)
    }
}
