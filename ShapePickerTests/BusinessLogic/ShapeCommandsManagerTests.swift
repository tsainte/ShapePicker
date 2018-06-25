//
//  ShapeCommandsManagerTests.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 25/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
@testable import ShapePicker
class ShapeCommandsManagerTests: XCTestCase {

    var shapeCommandsManager: ShapeCommandsManager!
    var commandExecutable: MockCommandExecutable!
    var plottableView: PlottableView!

    override func setUp() {
        super.setUp()
        commandExecutable = MockCommandExecutable()
        shapeCommandsManager = ShapeCommandsManager(commandsExecutable: commandExecutable)
        plottableView = plottable()
    }

    func plottable() -> PlottableView {
        return ShapeView(shape: .circle,
                         position: Position(relativeX: 0.5, relativeY: 0.5),
                         frame: .zero)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        shapeCommandsManager.add(plottableView)
        XCTAssertTrue(shapeCommandsManager.commands.last is AddShapeCommand,
                      "Command is not the correct type (add shape)")
        XCTAssertTrue(commandExecutable.addWasCalled, "Delegate was not called (add shape)" )
    }

    func testRemove() {
        shapeCommandsManager.remove(plottableView)
        XCTAssertTrue(shapeCommandsManager.commands.last is RemoveShapeCommand,
                      "Command is not the correct type (remove shape)")
        XCTAssertTrue(commandExecutable.removeWasCalled, "Delegate was not called (remove shape)" )
    }

    func testRemoveAll() {
        let plottables = [plottable(), plottable(), plottable()]
        shapeCommandsManager.removeAll(plottables)

        let removeAllCommand = shapeCommandsManager.commands.last
        XCTAssertTrue(removeAllCommand is GroupCommand, "Command is not the correct type (group shape)")
        XCTAssertEqual((removeAllCommand as? GroupCommand)?.commands.count ?? 0,
                       plottables.count,
                       "Group command has a wrong number of commands")
        XCTAssertEqual(commandExecutable.removeCount, plottables.count,
                       "Remove was not called the coorect number of times")
    }

    func testUndo() {
        shapeCommandsManager.add(plottableView)
        shapeCommandsManager.remove(plottableView)
        shapeCommandsManager.undo()
        XCTAssertTrue(shapeCommandsManager.commands.last is AddShapeCommand, "Command not removed after undo")
    }

    func testMove() {
        let originalPosition = Position(relativeX: 0.5, relativeY: 0.5)
        let newPosition = Position(relativeX: 0.25, relativeY: 0.25)

        shapeCommandsManager.move(plottableView, from: originalPosition, to: newPosition)
        XCTAssertTrue(shapeCommandsManager.commands.last is MoveShapeCommand,
                      "Command is not the correct type (move shape)")

        // Move is done by the user itself with gesture, but we can test the movement via undo
        shapeCommandsManager.undo()
        if let spyPosition = commandExecutable.moveToNewPosition {
            XCTAssertEqual(spyPosition, originalPosition, "Moved to different position (should be the original one)")
        } else {
            XCTFail("Delegate was not called (move shape)")
        }
    }
}
