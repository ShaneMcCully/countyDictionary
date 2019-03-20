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
    static let jsonFile = "counties2"
    static let json = "json"
    static let name = "name"
    static let id = "id"
    static let jsonError = "Something went wrong"
    static let tryAgain = "Please try again"
    static let extras = "extras"
    static let newborns = "new_borns_this_year"
    static let population = "population"

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

        print("name:\(county.countyName)")
        print("id:\(county.countyID)")
//        print("population: \(county.countyExtras?.newBorns)")
//        print("newBorns: \(county.countyExtras?.population)")
        print("population: \(county.countyExtras?[Constants.population])")
        print("newBorns: \(county.countyExtras?[Constants.newborns])")

        view.presentAlert(title: Constants.alertTitleBlock + county.countyName + Constants.alertTitleBlockEnd,
                          message: String(county.countyID)) { [weak self] in
                            self?.removeCounty(at: indexPath)
        }
    }

    // MARK: - Private Methods

    private func parseJSON() {
        var countyExtras: [String: Any]?//countyExtras?
        var countyPopulation: Int? = nil
        var countyNewborns: Int? = nil
        do {
            //create path/url
            if let path = Bundle.main.path(forResource: Constants.jsonFile, ofType: Constants.json) {

                // fetch the data from path/url
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                // create JSON object from data
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                // cast the json as [AnyObject](dictionary?) and assign to variable
                guard let counties = json as? [AnyObject] else { return }

                // iterate through
                for county in counties {
                    guard let name = county[Constants.name] as? String else { return }
                    guard let id = county[Constants.id] as? Int else { return }

                    // if the object has an "extras" field...
                    if let extras = county[Constants.extras] as? [String: Any] {
                        countyExtras = extras

                        // if the extras object has a newborns key-vlaue pair
                        if let newBorns = extras[Constants.newborns] as? Int {
                            countyNewborns = newBorns
                        }

                        // // if the extras object has a population key-value pair
                        if let population = extras[Constants.population] as? Int {
                            countyPopulation = population
                        }


                    } else {
                        countyExtras = nil
                    }
                    // instantiate county object with values extracted & append to array of counties
                    let countyObject = County(countyID: id, countyName: name, countyExtras: countyExtras)
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
