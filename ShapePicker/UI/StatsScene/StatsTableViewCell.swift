//
//  StatsTableViewCell.swift
//  ShapePicker
//
//  Created by Tiago Bencardino on 24/06/2018.
//  Copyright © 2018 Tiago Bencardino. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var shapeName: UILabel!
    @IBOutlet weak var shapeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(with displayModel: StatsTableViewCellDisplayModel) {
        shapeName.text = displayModel.name
        shapeCount.text = displayModel.count
    }
}
