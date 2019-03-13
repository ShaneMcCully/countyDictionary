//
//  CountyTableViewController.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import UIKit

private struct Constants {

    static let cellIdentifier = "CountyCell"
    static let okayString = "Okay"
    static let removeFromList = "Remove From List"

}

protocol CountyView: class {

    func presentAlert(county: County, title: String, message: String)

    func reloadData()
    
}

class CountyTableViewController: UITableViewController, CountyView, CountyDelegate {

    var presenter: CountyPresnter!
    weak var delegate: CountyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = CountyPresnter(view: self)
        presenter.viewDidLoad()
        presenter.delegate = self
    }

    func reloadData() {
        tableView.reloadData()
    }

    // MARK: - CountyDelegate methods

    func deleteCounty(county: County) {
        presenter.removeCounty(county: county)
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return presenter.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let county = presenter.fetchCounty(for: indexPath) else { fatalError("fatal error : fetchCounty") }
        let cell = CountyTableViewCell.deque(from: self.tableView,
                                             for: indexPath,
                                             with: county)
        return cell
    }

    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let county = presenter.fetchCounty(for: indexPath) else { fatalError("fatal error : fetchCounty") }
        presenter.presentAlert(county: county)
    }

}

// MARK: - UIAlertController

extension CountyTableViewController {

    func presentAlert(county: County, title: String, message: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction.init(title: Constants.okayString,
                                               style: .default,
                                               handler: { _ in
            alertView.dismiss(animated: true, completion: {} )
        }))
        alertView.addAction(UIAlertAction.init(title: Constants.removeFromList,
                                               style: .destructive,
                                               handler: { [weak self] _ in
            self?.presenter.deleteCounty(county: county)
        }))
        present(alertView, animated: true, completion: nil)
    }
}
