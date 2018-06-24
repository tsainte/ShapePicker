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

    static let animationTime = 0.25

    init(delegate: CanvasDelegate) {
        self.delegate = delegate
    }
 //todo remove
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
}

// MARK: Actions from View Controller
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

    func shapes(from canvas: UIView) -> [PlottableView] {
        return canvas.subviews.compactMap { $0 as? PlottableView }
    }

    func shapeStats(from canvas: UIView) -> [Shape: Int] {
        let shapes = canvas.subviews.compactMap { $0 as? Shapeable }
        var counters: [Shape: Int] = [:]

        shapes.forEach {
            //TODO: Consider change to CaseIterable once Swift 4.2 is available
            switch $0.shape as Shape {
            case .circle:
                counters[.circle] = (counters[.circle] ?? 0) + 1
            case .square:
                counters[.square] = (counters[.square] ?? 0) + 1
            case .triangle:
                counters[.triangle] = (counters[.triangle] ?? 0) + 1
            }
        }

        return counters
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
