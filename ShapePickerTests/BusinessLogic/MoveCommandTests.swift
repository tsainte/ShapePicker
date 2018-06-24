//
//  MoveCommandTests.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
@testable import ShapePicker

class MoveCommandTests: XCTestCase {

    let userPosition = Position(relativeX: 0.5, relativeY: 0.5)
    let undoPosition = Position(relativeX: 0.2, relativeY: 0.2)

    var plottableView: PlottableView!
    var mockMove: MockMoveExecutable!
    var tracker: MoveTracker!

    override func setUp() {
        super.setUp()
        plottableView = ShapeView(shape: .circle,
                                  position: userPosition,
                                  frame: .zero)
        mockMove = MockMoveExecutable()
        tracker = MoveTracker(from: undoPosition, to: userPosition)
    }

    override func tearDown() {
        plottableView = nil
        super.tearDown()
    }

    func testMoveExecutes() {
        let moveCommand = MoveShapeCommand(tracker: tracker,
                                           shape: plottableView,
                                           delegate: mockMove)
        moveCommand.execute()
        XCTAssertEqual(plottableView.position.relativeX, userPosition.relativeX)
    }

    func testMoveUndoes() {
        let moveCommand = MoveShapeCommand(tracker: tracker,
                                           shape: plottableView,
                                           delegate: mockMove)
        moveCommand.execute()
        moveCommand.undo()
        XCTAssertEqual(plottableView.position.relativeX, undoPosition.relativeX)
    }

}

class MockMoveExecutable: MoveExecutable {

    func performMove(on shape: PlottableView, to newPosition: Position) {
        shape.setNewPosition(newPosition, relativeTo: .zero)
    }
}
