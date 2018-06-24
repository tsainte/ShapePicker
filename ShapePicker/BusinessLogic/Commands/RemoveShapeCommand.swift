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
    let plottableView: PlottableView

    init(delegate: AddRemoveExecutable, plottableView: PlottableView) {
        self.delegate = delegate
        self.plottableView = plottableView
    }

    func execute() {
        delegate?.performRemove(plottableView)
    }

    func undo() {
        delegate?.performAdd(plottableView)
    }
}
