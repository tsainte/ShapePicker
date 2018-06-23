//
//  CanvasViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

protocol CanvasViewModelDelegate: class {
    func plot(view: UIView)
    func remove(view: UIView)
}

class CanvasViewModel: NSObject {

    weak var delegate: CanvasViewModelDelegate?
    lazy var shapeCommandsManager = ShapeCommandsManager(commandsExecutable: self)

    init(delegate: CanvasViewModelDelegate) {
        self.delegate = delegate
    }
}

//MARK: Actions from View Controller
extension CanvasViewModel {
    func create(shape: Shape) {
        let rect = CGRect(x: 0, y: 0, width: 44, height: 44)
        let position = Position(relativeX: 0.5, relativeY: 0.5)
        let shapeView = ShapeView(shape: shape, position:position, frame: rect)
        shapeCommandsManager.add(shapeView)
    }

    func undo() {
        shapeCommandsManager.undo()
    }
}

extension CanvasViewModel: CommandExecutable {
    func performAdd(_ shape: Plottable) {
        delegate?.plot(view: shape as! UIView) // todo
    }

    func performRemove(_ shape: Plottable) {
        delegate?.remove(view: shape as! UIView) // todo
    }

    func performMove(to: Position) {

    }

}
