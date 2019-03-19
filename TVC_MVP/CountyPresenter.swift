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
    static let counties = "counties"
    static let json = "json"
    static let name = "name"
    static let id = "id"
    static let jsonError = "Something went wrong"
    static let tryAgain = "Please try again"

}

class CountyPresenter: CountyPresenterProtocol {

    unowned let view: CountyViewProtocol
    var countyArray = [County]()

    // MARK: - Initialization

    required init(view: CountyViewProtocol) {
        self.view = view
    }

    // MARK: - CountyPresnterProtocol methods

    func viewDidLoad() {
        parseJSON()
    }

    func reloadData() {
        view.reloadData()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection() -> Int {
        return countyArray.count
    }

    func removeCounty(at indexPath: IndexPath) {
        countyArray.remove(at: indexPath.row)
        reloadData()
    }

    func fetchCounty(for indexPath: IndexPath) -> County? {
        return countyArray[indexPath.row]
    }

    func presentAlert(at indexPath: IndexPath) {
        let dismiss = AlertAction.DefaultActions.dismissAction()
        let delete = AlertAction.DefaultActions.deleteAction {
            self.removeCounty(at: indexPath)
        }
        let county = countyArray[indexPath.row]
        view.presentAlert(title: Constants.alertTitleBlock + county.countyName + Constants.alertTitleBlockEnd,
                          message: String(county.countyID),
                          actions: dismiss, delete)
    }

    func parseJSON() {
        do {
            if let path = Bundle.main.path(forResource: Constants.counties, ofType: Constants.json) {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let counties = json as? [AnyObject] {
                    for county in counties {
                        guard let name = county[Constants.name] as? String else { return }
                        guard let id = county[Constants.id] as? Int else { return }
                        let countyObject = County(countyID: id, countyName: name)
                        countyArray.append(countyObject)
                        reloadData()
                    }
                } else {
                    presentParseErrorAlert()
                }
            } else {
                presentParseErrorAlert()
            }
        } catch {
            presentParseErrorAlert()
            print(error.localizedDescription)
        }
    }

    // MARK: - Private Methods

    private func presentParseErrorAlert() {
        let dimiss = AlertAction.DefaultActions.dismissAction()
        let tryAgain = AlertAction.DefaultActions.tryAgainAction { [weak self] in
            self?.parseJSON()
        }
        view.presentAlert(title: Constants.jsonError, message: Constants.tryAgain, actions: dimiss, tryAgain)
    }
}
