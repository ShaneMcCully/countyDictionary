//
//  CountyTableViewCell.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import UIKit

class CountyTableViewCell: UITableViewCell {

    @IBOutlet weak var countyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(county: County) {
        countyLabel.text = county.countyName
    }

}
