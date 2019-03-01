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
    static let alertTitleBlock = "County ID for "
    static let alertTitleBlockEnd = " is"
    static let okayString = "Okay"
    static let headerTitle = "Counties"

}

protocol CountyView: class {

    func presentAlert(county: County, title: String, message: String)

    func reloadData()

}

class CountyTableViewController: UITableViewController, CountyView {

    var presenter: CountyPresnter!

    var countyArray: [County]? {
        didSet{
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = CountyPresnter(view: self)
        presenter.viewDidLoad()
    }

    func presentAlert(county: County) {
        let alertView = UIAlertController(title: Constants.alertTitleBlock + county.countyName + Constants.alertTitleBlockEnd, message: String(county.countyID), preferredStyle: .alert)
        alertView.addAction(UIAlertAction.init(title: Constants.okayString, style: .default, handler: { _ in
            alertView.dismiss(animated: true, completion: {
                print("dismiss")
            })
        }))
        self.present(alertView, animated: true, completion: nil)
    }

    func parseJSON() {
        countyArray = [County]()
        if let path = Bundle.main.path(forResource: "counties", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
                if let counties = json  {
                    for item in counties {
                        let name = item["name"] as! String
                        let id = item["id"] as! Int
                        let countyObject = County(countyID: id, countyName: name)
                        self.countyArray?.append(countyObject)
                    }
                }
            } catch {
                // error handling?
            }
        }
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countyArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! CountyTableViewCell
        if let county = countyArray?[indexPath.row] {
            if county.countyID == 0 {
                cell.isHidden = true
            }
            else {
                cell.setup(county: county)
                return cell
            }
        }
        return cell
    }

    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let county = countyArray?[indexPath.row] {
            presenter.presentAlert(county: county)
        }
        
    }


}
