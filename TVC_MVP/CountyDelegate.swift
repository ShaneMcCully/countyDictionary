//
//  CountyDelegate.swift
//  TVC_MVP
//
//  Created by Shane McCully on 01/03/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

protocol CountyDelegate: class {

    init(view: CountyViewProtocol)

    func reloadData()

    func viewDidLoad()

    func fetchCounty(for indexPath: IndexPath) -> County?

    func presentAlert(county:County)

    func numberOfSections() -> Int

    func numberOfRowsInSection() -> Int

    func removeCounty(county: County)

    func parseJSON()
    
}
