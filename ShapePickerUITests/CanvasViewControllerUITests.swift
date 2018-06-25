//
//  CanvasViewControllerUITests.swift
//  ShapePickerUITests
//
//  Created by Tiago Bencardino on 25/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
import Foundation
@testable import ShapePicker

class CanvasViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    struct Constants {
        static let canvasViewIdenfier = "CanvasView"
        static let squareButton = "squareButton"
        static let circleButton = "circleButton"
        static let triangleButton = "triangleButton"
        static let squareShapeIdentifier = "squareShapeView"
        static let circleShapeIdentifier = "circleShapeView"
        static let triangleShapeIdentifier = "triangleShapeView"
        static let navigationBarIdentifier = "ShapePicker.CanvasView"
        static let undoButton = "Undo"
        static let statsButton = "Stats"
        static let longPressTime = 0.6
    }

    // MARK: Setups

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {

        super.tearDown()
    }

    // MARK: Tests
    func testCreateSquares() {
        let squareButton = app.buttons[Constants.squareButton]
        squareButton.tap()
        squareButton.tap()
        squareButton.tap()

        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 3, "squares was not created")
    }

    func testCreateCircles() {
        let circleButton = app.buttons[Constants.circleButton]
        let squareButton = app.buttons[Constants.squareButton]

        circleButton.tap()
        circleButton.tap()
        squareButton.tap()
        circleButton.tap()

         XCTAssertEqual(countShapes(of: Constants.circleShapeIdentifier), 3, "circles was not created")
    }

    func testCreateTriangles() {
        let squareButton = app.buttons[Constants.squareButton]
        let circleButton = app.buttons[Constants.circleButton]
        let triangleButton = app.buttons[Constants.triangleButton]

        circleButton.tap()
        circleButton.tap()
        triangleButton.tap()
        circleButton.tap()
        squareButton.tap()

        XCTAssertEqual(countShapes(of: Constants.triangleShapeIdentifier), 1, "triangle was not created")
    }

    func testRemoveShapes() {
        let squareButton = app.buttons[Constants.squareButton]
        let circleButton = app.buttons[Constants.circleButton]
        let triangleButton = app.buttons[Constants.triangleButton]

        squareButton.tap()
        circleButton.tap()
        triangleButton.tap()
        triangleButton.tap()
        circleButton.tap()
        squareButton.tap()

        shape(of: Constants.squareShapeIdentifier).press(forDuration: Constants.longPressTime)
        shape(of: Constants.triangleShapeIdentifier).press(forDuration: Constants.longPressTime)
        shape(of: Constants.circleShapeIdentifier, boundBy: 1).press(forDuration: Constants.longPressTime)

        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 1, "square was not removed")
        XCTAssertEqual(countShapes(of: Constants.circleShapeIdentifier), 1, "circle was not removed")
        XCTAssertEqual(countShapes(of: Constants.triangleShapeIdentifier), 1, "triangle was not removed")
    }

    func testUndoAdd() {
        addSquare()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 1, "Square was not added")

        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 0, "Undo was not executed")
    }

    func testUndoRemove() {
        // 1. As we add a square, we should have one square
        addSquare()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 1, "Square was not added")

        // 2. As we remove a square, we should have zero squares
        shape(of: Constants.squareShapeIdentifier).press(forDuration: Constants.longPressTime)
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 0, "Square was not removed")

        // 3. As we undo the last action 'remove square', we should have 1 square
        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 1, "Undo was not executed")
    }

    func testMultipleUndo() {
        addSquare()
        addSquare()
        addSquare()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 3, "Squares were not added")

        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        XCTAssertEqual(countShapes(of: Constants.squareShapeIdentifier), 0, "Squares were not removed by undo")
    }

    func testMove() {
        addSquare()
        let square = shape(of: Constants.squareShapeIdentifier)
        let originalX = square.frame.origin.x
        let originalY = square.frame.origin.y

        let offsetX: CGFloat = 20.0
        let offsetY: CGFloat = 20.0

        // Move it! Pan gesture simulation
        // 1. Create a coordinate in the middle of the shape
        // 2. Create a coordinate in a different point of the screen, relative to the shape
        // 3. Execute a drag from one point to another
        let coord1 = square.coordinate(withNormalizedOffset: CGVector(dx: 0.50, dy: 0.50))
        let coord2 = coord1.withOffset(CGVector(dx: offsetX, dy: offsetY))
        coord1.press(forDuration: 0.3, thenDragTo: coord2)

        XCTAssertNotEqual(originalX, square.frame.origin.x - offsetX, "Can't move shape")
        XCTAssertNotEqual(originalY, square.frame.origin.y - offsetY, "Can't move shape")
    }

    func testUndoMove() {
        addSquare()
        let square = shape(of: Constants.squareShapeIdentifier)
        let originalX = square.frame.origin.x
        let originalY = square.frame.origin.y

        let offsetX: CGFloat = 20.0
        let offsetY: CGFloat = 20.0

        let coord1 = square.coordinate(withNormalizedOffset: CGVector(dx: 0.50, dy: 0.50))
        let coord2 = coord1.withOffset(CGVector(dx: offsetX, dy: offsetY))
        coord1.press(forDuration: 0.3, thenDragTo: coord2)

        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.undoButton].tap()
        XCTAssertEqual(originalX, square.frame.origin.x, "Can't undo 'move' properly")
        XCTAssertEqual(originalY, square.frame.origin.y, "Cant' undo 'move' properly")
    }

    func testChangeToStatsScene() {
        app.navigationBars[Constants.navigationBarIdentifier].buttons[Constants.statsButton].tap()
        XCTAssert(app.navigationBars["Stats"].exists, "Wrong screen")
    }
}

// Helpers
extension CanvasViewControllerUITests {

    func countShapes(of identifier: String) -> Int {
        let shapes = app.otherElements[Constants.canvasViewIdenfier]
            .children(matching: .other)
            .matching(identifier: identifier)
        return shapes.count
    }

    func shape(of identifier: String, boundBy bound: Int = 0) -> XCUIElement {
        return app.otherElements[Constants.canvasViewIdenfier]
            .children(matching: .other)
            .matching(identifier: identifier)
            .element(boundBy: bound)
    }

    func addSquare() {
        let squareButton = app.buttons[Constants.squareButton]
        squareButton.tap()
    }
}
