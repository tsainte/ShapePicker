//
//  CanvasViewModel.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 23/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

protocol CanvasViewModelDelegate: class {

}
class CanvasViewModel: NSObject {

    weak var delegate: CanvasViewModelDelegate?
    init(delegate: CanvasViewModelDelegate) {
        self.delegate = delegate
    }
}
