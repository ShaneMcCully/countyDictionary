//
//  CountyPresenter.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

private struct Constants {

    static let alertTitleBlock = "County ID for "
    static let alertTitleBlockEnd = " is"
    static let headerTitle = "Counties"
    static let counties = "counties"
    static let json = "json"
    static let name = "name"
    static let id = "id"

}

class CountyPresenter: CountyDelegate {

    unowned let view: CountyViewProtocol
    weak var delegate: CountyDelegate?

    var countyArray: [County]?

    required init(view: CountyViewProtocol) {
        self.view = view
    }

    func reloadData() {
        view.reloadData()
    }

    func viewDidLoad() {
        parseJSON()
    }

    func fetchCounty(for indexPath: IndexPath) -> County? {
        return countyArray?[indexPath.row]
    }

    func presentAlert(county: County) {
        let dismiss = AlertAction.DefaultActions.dismissAction()
        let delete = AlertAction.DefaultActions.deleteAction { [weak self] in
            self?.removeCounty(county: county) // should I be calling a view function here?
        }
        view.presentAlert(title: Constants.alertTitleBlock + county.countyName + Constants.alertTitleBlockEnd,
                          message: String(county.countyID),
                          actions: dismiss, delete)
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection() -> Int {
        return countyArray?.count ?? 0
    }

    func removeCounty(county: County) {
        countyArray?.removeAll{ $0.countyID == county.countyID }
        reloadData()
    }

    func parseJSON() {
        countyArray = [County]()
        do {
            if let path = Bundle.main.path(forResource: Constants.counties, ofType: Constants.json) {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let counties = json as? [AnyObject] {
                    for county in counties {
                        guard let name = county[Constants.name] as? String else { fatalError() } // what should be here instead of fatal error?
                        guard let id = county[Constants.id]  as? Int else { fatalError() }
                        let countyObject = County(countyID: id, countyName: name)
                        countyArray?.append(countyObject)
                        reloadData()
                    }
                } else {
                    print("JSON error")
                }
            } else {
                print("File path error")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
