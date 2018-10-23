//
//  StatsTableViewManager.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class StatsTableViewManager: NSObject {

    weak var tableView: UITableView!
    weak var dataProvider: StatsDataProvider!
    weak var actionHandler: StatsActionHandler?

    init(tableView: UITableView, dataProvider: StatsDataProvider, actionHandler: StatsActionHandler) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        self.actionHandler = actionHandler
        super.init()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension StatsTableViewManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell") as? StatsTableViewCell ??
            StatsTableViewCell()

        let displayModel = dataProvider.displayModel(for: indexPath.row)
        cell.configureCell(with: displayModel)
        return cell
    }
}

extension StatsTableViewManager: UITableViewDelegate {
    // this method handles row deletion
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            actionHandler?.removeAll(for: indexPath)
        }
    }
}
