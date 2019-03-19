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
    static let alertTitleBlock = "County ID for "
    static let alertTitleBlockEnd = " is"

}

class CountyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CountyViewProtocol {

    @IBOutlet private weak var tableView: UITableView!
    var presenter: CountyPresenterProtocol!

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
        guard let county = presenter.getObject(at: indexPath) else { fatalError(Constants.errorText) }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                       for: indexPath) as? CountyTableViewCell else { return UITableViewCell() }
        cell.setup(with: county)
        return cell
    }

    // MARK: - UITableViewDelegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(indexPath: indexPath)
    }

    // MARK: - CountyViewProtocol methods

    func reloadData() {
        tableView.reloadData()
    }

    func presentAlert(title: String, message: String, action: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let action = action else { return }
        alert.addAction(UIAlertAction(title: Constants.okayString, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.removeFromList, style: .destructive, handler: { _ in
            action()
        }))
        present(alert, animated: true, completion: nil)
    }

}

