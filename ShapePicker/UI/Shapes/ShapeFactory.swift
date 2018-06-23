//
//  ShapeFactory.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

enum Shape {
    case circle
    case square
    case triangle
}

class ShapeFactory {

    static let fillColor: UIColor = .lightGray
    static let strokeColor: UIColor = .black

    static func createLayer(at rect: CGRect, for shape: Shape) -> CAShapeLayer {
        switch shape {
        case .circle:
            return circleLayer(at: rect)
        case .square:
            return squareLayer(at: rect)
        case .triangle:
            return triangleLayer(at: rect)
        }
    }

    private static func circleLayer(at rect: CGRect) -> CAShapeLayer {
        let radius = min(rect.size.height, rect.size.width)
        let path = UIBezierPath(ovalIn: CGRect(x: rect.origin.x,
                                               y: rect.origin.y,
                                               width: radius,
                                               height: radius))

        return defaultShapeLayer(at: rect, path: path.cgPath)
    }

    private static func squareLayer(at rect: CGRect) -> CAShapeLayer {
        let side = min(rect.size.height, rect.size.width)
        let path = UIBezierPath(rect: CGRect(x: rect.origin.x,
                                             y: rect.origin.y,
                                             width: side,
                                             height: side))
        return defaultShapeLayer(at: rect, path: path.cgPath)
    }

    private static func triangleLayer(at rect: CGRect) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxX))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minX))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxX))
        path.close()

        return defaultShapeLayer(at: rect, path: path.cgPath)
    }

    private static func defaultShapeLayer(at rect: CGRect, path: CGPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = rect
        shapeLayer.path = path
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        return shapeLayer
    }
}
