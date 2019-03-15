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
    static let errorText = "fatal error : fetchCounty"

}

class CountyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CountyViewProtocol {

    var presenter: CountyPresnterProtocol!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = CountyPresenter(view: self)
        presenter.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return presenter.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let county = presenter.fetchCounty(for: indexPath) else { fatalError(Constants.errorText) }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? CountyTableViewCell else { return UITableViewCell() }
        cell.setup(with: county)
        return cell
    }

    // MARK: - UITableViewDelegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentAlert(at: indexPath)
    }

    // MARK: - CountyViewProtocol methods

    func presentAlert(title: String?, message: String?, actions: AlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.title, style: (action.style?.mapStyle)!, handler: { _ in
                action.action?()
            }))
        }
        present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        tableView.reloadData()
    }

}

