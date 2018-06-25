//
//  MockCommandExecutable.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 25/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

@testable import ShapePicker

class MockCommandExecutable: CommandExecutable {

    var addWasCalled = false
    var removeWasCalled = false
    var removeAllWasCalled = false
    var moveToNewPosition: Position?
    var removeCount = 0

    func performAdd(_ plottableView: PlottableView) {
        addWasCalled = true
    }

    func performRemove(_ plottableView: PlottableView) {
        removeWasCalled = true
        removeCount += 1
    }

    func performRemoveAll(_ shape: Shape) {
        removeAllWasCalled = true
    }

    func performMove(on plottableView: PlottableView, to newPosition: Position) {
        moveToNewPosition = newPosition
    }
}
