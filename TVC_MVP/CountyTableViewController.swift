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

}

protocol CountyView: class {

    func presentAlert(county: County, title: String, message: String)

    func reloadData()

}

class CountyTableViewController: UITableViewController, CountyView {

    var presenter: CountyPresnter!
    weak var delegate: CountyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self as? CountyDelegate
        presenter = CountyPresnter(view: self)
        presenter.viewDidLoad()
    }

    func reloadData() {
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return presenter.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CountyTableViewCell
        guard let county = presenter.fetchCounty(for: indexPath) else { fatalError("fatal error : fetchCounty") }
        cell.setup(with: county, at: indexPath)
        return cell
    }

    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let county = presenter.fetchCounty(for: indexPath) else { fatalError("fatal error : fetchCounty") }
        presenter.presentAlert(county: county)
    }

}

extension CountyTableViewController {

    func presentAlert(county: County, title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction.init(title: Constants.okayString, style: .default, handler: { _ in
            alertView.dismiss(animated: true, completion: {
                print("dismiss")
            })
        }))
        present(alertView, animated: true, completion: nil)
    }
}
