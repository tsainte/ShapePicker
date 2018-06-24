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
        tableViewManager = StatsTableViewManager(tableView: tableView, viewModel: viewModel)
    }
}

extension StatsViewController: StatsViewModelDelegate { }
