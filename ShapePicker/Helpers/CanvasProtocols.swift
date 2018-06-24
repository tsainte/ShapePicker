//
//  CanvasProtocols.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

typealias PlottableView = UIView & Plottable

// Defines an object that can be plotted
protocol Plottable: class {
    var position: Position! { get }
    func setNewPosition(_ position: Position, relativeTo size: CGSize)
}

protocol Shapeable {
    var shape: Shape! { get }
}
