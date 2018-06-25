//
//  StatsTableViewManagerTests.swift
//  ShapePickerTests
//
//  Created by Tiago Bencardino on 25/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import XCTest
@testable import ShapePicker

class StatsTableViewManagerTests: XCTestCase {

    var viewManager: StatsTableViewManager!
    var dataProvider: StatsDataProvider!
    var actionHandler: StatsActionHandler!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        tableView = UITableView()
        dataProvider = MockStatsDataProvider()
        actionHandler = SpyStatsActionHandler()
        viewManager = StatsTableViewManager(tableView: tableView,
                                            dataProvider: dataProvider,
                                            actionHandler: actionHandler)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(viewManager.tableView(tableView, numberOfRowsInSection: 0), 2,
                       "Wrong number of rows - should be 2")
    }
}

class MockStatsDataProvider: StatsDataProvider {

    let displayModels = [StatsTableViewCellDisplayModel(shape: .circle, count: "10"),
                         StatsTableViewCellDisplayModel(shape: .square, count: "20")]

    var numberOfRows: Int {
        return displayModels.count
    }

    func displayModel(for index: Int) -> StatsTableViewCellDisplayModel {
        return displayModels[index]
    }
}

class SpyStatsActionHandler: StatsActionHandler {
    var removeAllWasCalled = false
    func removeAll(for indexPath: IndexPath) {
        removeAllWasCalled = true
    }
}
