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
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (_) in
            // Reposition centres once view transition
            self.viewModel.shapes(from: self.canvasView).forEach {
                $0.setNewPosition($0.position, relativeTo: self.canvasSize)
            }
        }
    }

    // TODO: consider move to a coordinator class (MVVM-C)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let statsViewController = segue.destination as? StatsViewController else { return }
        let statsViewModel = StatsViewModel(delegate: statsViewController,
                                            shapeStats: viewModel.shapeStats(from: canvasView))
        statsViewController.viewModel = statsViewModel
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
        UIView.animate(withDuration: CanvasViewModel.animationTime) {
            view.alpha = 1
        }
        canvasView.addSubview(view)
    }

    func remove(view: PlottableView) {
        UIView.animate(withDuration: CanvasViewModel.animationTime,
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
        UIView.animate(withDuration: CanvasViewModel.animationTime,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        view.setNewPosition(newPosition, relativeTo: self.canvasSize)
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
