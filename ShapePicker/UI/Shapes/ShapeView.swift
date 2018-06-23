//
//  TriangleView.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit
class ShapeView: UIView, Plottable {

    var position: Position = Position(relativeX: 0, relativeY: 0)
    var shapeLayer: CAShapeLayer!
    var shape: Shape!

    init(shape: Shape, position: Position, frame: CGRect) {
        self.position = position
        self.shape = shape
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        shapeLayer = ShapeFactory.createLayer(at: rect, for: shape)
        layer.addSublayer(shapeLayer)
    }
}
