//
//  CountyTableViewCell.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import UIKit

class CountyTableViewCell: UITableViewCell {

    @IBOutlet private weak var countyLabel: UILabel!

    func setup(with county: County) {
        countyLabel.text = county.countyName
    }

}
