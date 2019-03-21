//
//  CountyPresenter.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

private struct Constants {

    static let alertTitleBlock = "County ID: "
    static let alertNewborns = "Newborns: "
    static let alertPopulation = "Population: "
    static let jsonFile = "counties2"
    static let json = "json"
    static let name = "name"
    static let id = "id"
    static let extras = "extras"
    static let newborns = "new_borns_this_year"
    static let population = "population"
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

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection() -> Int {
        return countyArray.count
    }

    func getObject(at indexPath: IndexPath) -> County? {
        return countyArray[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        let county = countyArray[indexPath.row]
        view.presentAlert(title: county.countyName,
                          message: generateAlertMessage(county: county)) { [weak self] in
                            self?.removeCounty(at: indexPath)
        }
    }

    // MARK: - Private Methods

    private func parseJSON() {
        do {
            if let path = Bundle.main.path(forResource: Constants.jsonFile, ofType: Constants.json) {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let counties = json as? [[AnyHashable:Any]] else { return }
                for county in counties {
                    guard let name = county[Constants.name] as? String,
                        let id = county[Constants.id] as? Int else { return }
                    var countyObject = County(countyID: id, countyName: name)
                    if let extras = county[Constants.extras] as? [String: Any] {
                        var countyExtras = CountyExtras()
                        countyExtras.newBorns = extras[Constants.newborns] as? Int
                        countyExtras.population = extras[Constants.population] as? Int
                        countyObject.countyExtras = countyExtras
                    }
                    countyArray.append(countyObject)
                }
                reloadData()
            } else {
                presentJSONErrorAlert()
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    private func generateAlertMessage(county: County) -> String {
        var newbornString: String = ""
        var populationString: String = ""
        let id = Constants.alertTitleBlock + String(county.countyID)
        let extras = county.countyExtras
        if extras != nil {
            if let nb = extras?.newBorns {
                newbornString = Constants.alertNewborns + String(describing: nb)
            }
            if let pop = extras?.population {
                populationString = Constants.alertPopulation + String(describing: pop)
            }
            return id + "\n" + populationString + "\n" + newbornString
        }
        return id
    }

    private func presentJSONErrorAlert() {
        view.presentAlert(title: Constants.jsonError, message: Constants.tryAgain) { [weak self] in
            self?.parseJSON()
        }
    }

    private func reloadData() {
        view.reloadData()
    }

    private func removeCounty(at indexPath: IndexPath) {
        countyArray.remove(at: indexPath.row)
        reloadData()
    }

}
