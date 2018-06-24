//
//  CanvasViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

@objc protocol CanvasGestureDelegate: class {
    @objc func move(recognizer: UIPanGestureRecognizer)
}

protocol CanvasViewModelDelegate: class {
    func plot(view: PlottableView)
    func remove(view: PlottableView)
    func move(view: PlottableView, to newPosition: Position)
}

typealias CanvasDelegate = CanvasViewModelDelegate & CanvasGestureDelegate

class CanvasViewModel: NSObject {

    weak var delegate: CanvasDelegate?
    lazy var shapeCommandsManager = ShapeCommandsManager(commandsExecutable: self)

    init(delegate: CanvasDelegate) {
        self.delegate = delegate
    }
 //todo remove
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
}

//MARK: Actions from View Controller
extension CanvasViewModel {
    func create(shape: Shape, canvasSize: CGSize) {
        let rect = CGRect(x: 0, y: 0, width: 44, height: 44)
        let position = Position(relativeX: CGFloat(Double(random(10 ..< 90)) / 100),
                                relativeY: CGFloat(Double(random(10 ..< 90)) / 100))
        
        let shapeView = ShapeView(shape: shape, position: position, frame: rect)
        shapeView.center = position.pointExtended(by: canvasSize)
        
        let recognizer = UIPanGestureRecognizer(target: delegate,
                                                action: #selector(delegate?.move(recognizer:)))
        shapeView.addGestureRecognizer(recognizer)
        
        shapeCommandsManager.add(shapeView)
    }

    func userMoved(shape: PlottableView, from oldPosition: Position, to newPosition: Position) {
        shapeCommandsManager.move(shape, from: oldPosition, to: newPosition)
    }

    func undo() {
        shapeCommandsManager.undo()
    }
}

extension CanvasViewModel: CommandExecutable {
    func performAdd(_ shape: PlottableView) {
        delegate?.plot(view: shape)
    }

    func performRemove(_ shape: PlottableView) {
        delegate?.remove(view: shape)
    }

    func performMove(on shape: PlottableView, to newPosition: Position) {
        delegate?.move(view: shape, to: newPosition)
    }

}
