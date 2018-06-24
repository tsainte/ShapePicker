//
//  StatsViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

protocol StatsViewModelDelegate: class {
    func removeCells(at indexPaths: [IndexPath])
}

struct StatsTableViewCellDisplayModel {
    var shape: Shape
    var name: String {
        return shape.rawValue
    }
    var count: String
}

class StatsViewModel: NSObject {

    weak var delegate: StatsViewModelDelegate?
    var displayModels: [StatsTableViewCellDisplayModel]!
    weak var commandExecuter: CommandExecutable?

    init(delegate: StatsViewModelDelegate, commandExecuter: CommandExecutable, shapeStats: [Shape: Int]) {
        self.delegate = delegate
        self.commandExecuter = commandExecuter
        displayModels = shapeStats.map { return StatsTableViewCellDisplayModel(shape: $0.key,
                                                                               count: String($0.value) )}
    }

    var numberOfRows: Int {
        return displayModels.count
    }

    func displayModel(for index: Int) -> StatsTableViewCellDisplayModel {
        return displayModels[index]
    }
}

// MARK: Actions from the user
extension StatsViewModel {
    func removeAll(for indexPath: IndexPath) {
        let shape = displayModels[indexPath.row].shape
        commandExecuter?.performRemoveAll(shape)

        displayModels.remove(at: indexPath.row)
        delegate?.removeCells(at: [indexPath])
    }
}
