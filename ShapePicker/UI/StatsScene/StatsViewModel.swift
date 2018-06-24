//
//  StatsViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

protocol StatsViewModelDelegate: class { }

struct StatsTableViewCellDisplayModel {
    var name: String
    var count: String
}

class StatsViewModel: NSObject {

    weak var delegate: StatsViewModelDelegate?
    var displayModels: [StatsTableViewCellDisplayModel]!

    init(delegate: StatsViewModelDelegate, shapeStats: [Shape: Int]) {
        self.delegate = delegate
        displayModels = shapeStats.map { return StatsTableViewCellDisplayModel(name: $0.key.rawValue,
                                                                               count: String($0.value) )}
    }

    var numberOfRows: Int {
        return displayModels.count
    }

    func displayModel(for index: Int) -> StatsTableViewCellDisplayModel {
        return displayModels[index]
    }

}
