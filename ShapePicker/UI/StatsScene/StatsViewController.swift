//
//  StatsViewController.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: StatsViewModel!
    var tableViewManager: StatsTableViewManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewManager = StatsTableViewManager(tableView: tableView,
                                                 dataProvider: viewModel,
                                                 actionHandler: viewModel)
    }
}

extension StatsViewController: StatsViewModelDelegate {
    func removeCells(at indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths, with: .fade)
        tableView.endUpdates()
    }
}
