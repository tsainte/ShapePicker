//
//  StatsViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

protocol StatsViewModelDelegate: class {

}

class StatsViewModel: NSObject {

    weak var delegate: StatsViewModelDelegate?
    init(delegate: StatsViewModelDelegate) {
        self.delegate = delegate
    }

}
