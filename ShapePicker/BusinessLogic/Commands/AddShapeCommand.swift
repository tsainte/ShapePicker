//
//  AddCommand.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import Foundation

protocol AddRemoveExecutable: class {
    func performAdd(_ plottableView: PlottableView)
    func performRemove(_ plottableView: PlottableView)
    func performRemoveAll(_ shape: Shape)
}

class AddShapeCommand: UndoableCommand {
    weak var delegate: AddRemoveExecutable?
    let plottableView: PlottableView

    init(delegate: AddRemoveExecutable, plottableView: PlottableView) {
        self.delegate = delegate
        self.plottableView = plottableView
    }
    func execute() {
        delegate?.performAdd(plottableView)
    }
    func undo() {
        delegate?.performRemove(plottableView)
    }
}
