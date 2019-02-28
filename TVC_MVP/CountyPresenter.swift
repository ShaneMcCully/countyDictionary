//
//  CountyPresenter.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

class CountyPresnter {

    unowned let view: CountyView

    init(view: CountyView) {
        self.view = view
    }

    func viewDidLoad() {
        view.parseJSON()
    }

    func parseJSON() -> [County] {
        let parsedJSON = view.parseJSON()
        return parsedJSON
    }

    func presentAlert(county: County) {
        view.presentAlert(county: county)
    }

}

// Presenter - needs to call the view functions (which in turn are implemented within the VC)
