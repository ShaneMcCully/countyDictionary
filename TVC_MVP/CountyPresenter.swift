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

}

class CountyPresnter {

    unowned let view: CountyView
    weak var delegate: CountyDelegate?

    var countyArray: [County]? {
        didSet {
            view.reloadData()
        }
    }

    init(view: CountyView) {
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
        view.presentAlert(county: county, title: Constants.alertTitleBlock + county.countyName + Constants.alertTitleBlockEnd, message: String(county.countyID))
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRowsInSection() -> Int {
        return countyArray?.count ?? 0
    }

    func deleteCounty(county: County) {
        countyArray?.removeAll{ $0.countyID == county.countyID }
        reloadData()
    }

    func parseJSON() {
        countyArray = [County]()
        do {
            if let path = Bundle.main.path(forResource: "counties", ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let counties = json as? [AnyObject] {
                    for county in counties {
                        guard let name = county["name"] as? String else { fatalError() }
                        guard let id = county["id"]  as? Int else { fatalError() }
                        let countyObject = County(countyID: id, countyName: name)
                        countyArray?.append(countyObject)
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
