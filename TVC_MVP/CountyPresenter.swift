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

    func presentAlert(county: County) {
        view.presentAlert(county: county)
    }

}
