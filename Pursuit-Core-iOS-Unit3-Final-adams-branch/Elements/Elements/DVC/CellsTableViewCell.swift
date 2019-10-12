//
//  CellsTableViewCell.swift
//  Elements
//
//  Created by God on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class CellsTableViewCell: UITableViewCell {
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var atomicWeightLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
