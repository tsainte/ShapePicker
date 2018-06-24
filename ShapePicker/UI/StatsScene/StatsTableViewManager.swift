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
    weak var viewModel: StatsViewModel!

    init(tableView: UITableView, viewModel: StatsViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()

        tableView.dataSource = self
    }
}

extension StatsTableViewManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell") as? StatsTableViewCell else {
            fatalError("Can't dequeue correct cell")
        }
        
        let displayModel = viewModel.displayModel(for: indexPath.row)
        cell.configureCell(with: displayModel)
        return cell
    }
}

extension StatsTableViewManager: UITableViewDelegate {

}
