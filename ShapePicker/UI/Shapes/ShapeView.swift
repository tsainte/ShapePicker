//
//  TriangleView.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit
class ShapeView : UIView {

    var shapeLayer: CAShapeLayer!
    var shape: Shape

    init(shape: Shape, frame: CGRect) {
        self.shape = shape
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.shape = .square
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        shapeLayer = ShapeFactory.createLayer(at: rect, for: shape)
        layer.addSublayer(shapeLayer)
    }
}
