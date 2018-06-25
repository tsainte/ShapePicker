//
//  StatsViewModelTests.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 25/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
@testable import ShapePicker

class StatsViewModelTests: XCTestCase {

    var viewModel: StatsViewModel!
    var viewModelDelegate: MockViewModelDelegate!
    var commandExecuter: MockCommandExecutable!

    override func setUp() {
        super.setUp()
        viewModelDelegate = MockViewModelDelegate()
        commandExecuter = MockCommandExecutable()
        let stats: [Shape: Int] = [.circle: 10, .square: 20, .triangle: 30]

        viewModel = StatsViewModel(delegate: viewModelDelegate,
                                   commandExecuter: commandExecuter,
                                   shapeStats: stats)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNumberOfRows() {
        XCTAssertEqual(viewModel.numberOfRows, 3, "Wrong number of rows")
    }

    func testRemoveAll() {
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.removeAll(for: indexPath)
        XCTAssertTrue(viewModelDelegate.removeCellWasCalledWithOneCell, "remove cell was not called as expected")
        XCTAssertTrue(commandExecuter.removeAllWasCalled, "remove all shapes was not called")
    }
}

class MockViewModelDelegate: StatsViewModelDelegate {

    var removeCellWasCalledWithOneCell = false

    func removeCells(at indexPaths: [IndexPath]) {
        removeCellWasCalledWithOneCell = indexPaths.count == 1
    }
}
