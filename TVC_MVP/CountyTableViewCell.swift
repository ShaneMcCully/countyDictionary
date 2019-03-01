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

    static let cellIdentifier = "CountyCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with county: County, at indexPath: IndexPath) {
        countyLabel.text = county.countyName
    }

    static func deque(from tableView: UITableView, for indexPath: IndexPath, with county: County) -> CountyTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountyTableViewCell
        cell?.setup(with: county, at: indexPath)
        return cell ?? CountyTableViewCell()
    }

}
