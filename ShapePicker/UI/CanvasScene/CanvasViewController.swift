//
//  CanvasViewController.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: UIView! {
        didSet {
            canvasView.clipsToBounds = true
        }
    }
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var triangleButton: UIButton!

    lazy var viewModel = CanvasViewModel(delegate: self)
    var initialPosition: Position?
    var canvasSize: CGSize {
        return canvasView.frame.size
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (_) in
            self.canvasView.subviews.forEach {
                guard let plottableView = $0 as? PlottableView else { return }
                plottableView.setNewPosition(plottableView.position,
                                             relativeTo: self.canvasSize)
            }
        }
    }
}

// MARK: Actions
extension CanvasViewController {
    @IBAction func addSquareTapped() {
        viewModel.create(shape: .square, canvasSize: canvasSize)
    }

    @IBAction func addCircleTapped() {
        viewModel.create(shape: .circle, canvasSize: canvasSize)
    }

    @IBAction func addTriangleTapped() {
        viewModel.create(shape: .triangle, canvasSize: canvasSize)
    }

    @IBAction func undoTapped() {
        viewModel.undo()
    }
}

extension CanvasViewController: CanvasViewModelDelegate {

    func plot(view: PlottableView) {
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1
        }
        canvasView.addSubview(view)
    }

    func remove(view: PlottableView) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        view.alpha = 0
        },
                       completion: { _ in
                        view.removeFromSuperview()
        })
    }


    func move(view: PlottableView, to newPosition: Position) {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        view.setNewPosition(newPosition, relativeTo: self.canvasView.frame.size)
        },
                       completion: nil)
    }

}

extension CanvasViewController: CanvasGestureDelegate {
    func move(recognizer: UIPanGestureRecognizer) {
        guard let view = recognizer.view as? PlottableView else { return }
        switch recognizer.state {
        case .began:
            initialPosition = view.position
            canvasView.bringSubview(toFront: view)
        case .changed:
            let translation = recognizer.translation(in: canvasView)
            let newCenter = CGPoint(x: view.center.x + translation.x,
                                    y: view.center.y + translation.y)

            view.setNewPosition(newCenter.positionNormalized(by: canvasSize),
                                                 relativeTo: canvasSize)

            recognizer.setTranslation(CGPoint.zero, in: canvasView)
        case .ended:
            if let initialPosition = initialPosition {
                viewModel.userMoved(shape: view, from: initialPosition, to: view.position)
            }
        default:
            return
        }
    }
}
