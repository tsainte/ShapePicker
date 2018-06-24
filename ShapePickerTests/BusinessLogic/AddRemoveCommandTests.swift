//
//  AddRemoveCommandTests.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
@testable import ShapePicker

class AddRemoveCommandTests: XCTestCase {

    var plottableView: PlottableView!
    var spy: SpyAddRemoveExecutable!
    override func setUp() {
        super.setUp()
        plottableView = plottable()
        spy = SpyAddRemoveExecutable()
    }

    func plottable() -> PlottableView {
        return ShapeView(shape: .circle,
                         position: Position(relativeX: 0.5, relativeY: 0.5),
                         frame: .zero)
    }

    override func tearDown() {
        plottableView = nil
        super.tearDown()
    }
    
    func testAddShapeExecutes() {
        let addShapeCommand = AddShapeCommand(delegate: spy, plottableView: plottableView)
        addShapeCommand.execute()
        XCTAssertTrue(spy.performAddWasCalled)
    }

    func testRemoveShapeExecutes() {
        let removeShapeCommand = RemoveShapeCommand(delegate: spy, plottableView: plottableView)
        removeShapeCommand.execute()
        XCTAssertTrue(spy.performRemoveWasCalled)
    }

    func testAddShapeUndoes() {
        let addShapeCommand = AddShapeCommand(delegate: spy, plottableView: plottableView)
        addShapeCommand.execute()
        addShapeCommand.undo()
        XCTAssertTrue(spy.performRemoveWasCalled)
    }

    func testRemoveShapeUndoes() {
        let addShapeCommand = RemoveShapeCommand(delegate: spy, plottableView: plottableView)
        addShapeCommand.execute()
        addShapeCommand.undo()
        XCTAssertTrue(spy.performAddWasCalled)
    }

    func testRemoveAllExecutes() {
        let commands = [RemoveShapeCommand(delegate: spy, plottableView: plottable()),
                        RemoveShapeCommand(delegate: spy, plottableView: plottable()),
                        RemoveShapeCommand(delegate: spy, plottableView: plottable())]
        let groupCommand = GroupCommand(commands: commands)
        groupCommand.execute()
        XCTAssertEqual(spy.countRemoves, 3)
    }

    func testRemoveAllUndoes() {
        let commands = [RemoveShapeCommand(delegate: spy, plottableView: plottable()),
                        RemoveShapeCommand(delegate: spy, plottableView: plottable())]
        let groupCommand = GroupCommand(commands: commands)
        groupCommand.execute()
        groupCommand.undo()
        XCTAssertEqual(spy.countAdds, 2)
    }
}

class SpyAddRemoveExecutable: AddRemoveExecutable {
    var performAddWasCalled = false
    var performRemoveWasCalled = false
    var performRemoveAllWasCalled = false

    var countAdds = 0
    var countRemoves = 0
    func performAdd(_ plottableView: PlottableView) {
        performAddWasCalled = true
        countAdds += 1
    }

    func performRemove(_ plottableView: PlottableView) {
        performRemoveWasCalled = true
        countRemoves += 1
    }

    func performRemoveAll(_ shape: Shape) {
        performRemoveAllWasCalled = true
    }
}
