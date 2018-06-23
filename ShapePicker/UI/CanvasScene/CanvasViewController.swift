//
//  CanvasViewController.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var squareButton: UIButton!
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet weak var triangleButton: UIButton!

    lazy var viewModel = CanvasViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
        }) { (_) in
//            self.positionShape()
        }
    }

//    func positionShape() {
//        let relativeX: CGFloat = 0.5
//        let relativeY: CGFloat = 0.5
//
//        shapeView?.center = CGPoint(x: canvasView.frame.size.width * relativeX,
//                               y: canvasView.frame.size.height * relativeY)
//    }
//
//    func create(shape: Shape) {
//        self.shapeView?.removeFromSuperview()
//
//        let relativeX: CGFloat = 0.5
//        let relativeY: CGFloat = 0.5
//
//        let shapeView = ShapeView(shape: shape,
//                              frame: CGRect(x: 0,
//                                        y: 0,
//                                        width: 44,
//                                        height: 44))
//        shapeView.backgroundColor = canvasView.backgroundColor
//        canvasView.addSubview(shapeView)
//        self.shapeView = shapeView
//        positionShape()
//    }
}

// MARK: Actions
extension CanvasViewController {
    @IBAction func addSquareTapped() {
        viewModel.create(shape: .square)
    }

    @IBAction func addCircleTapped() {
        viewModel.create(shape: .circle)
    }

    @IBAction func addTriangleTapped() {
        viewModel.create(shape: .triangle)
    }

    @IBAction func undoTapped() {
        viewModel.undo()
    }
}

extension CanvasViewController: CanvasViewModelDelegate {

    func plot(view: UIView) {
        canvasView.addSubview(view)
    }

    func remove(view: UIView) {
        view.removeFromSuperview()
    }
}
