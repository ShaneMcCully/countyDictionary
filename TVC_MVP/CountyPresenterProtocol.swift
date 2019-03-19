//
//  CountyPresnterProtocol.swift
//  TVC_MVP
//
//  Created by Shane McCully on 01/03/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

protocol CountyPresenterProtocol: class {

    init(view: CountyViewProtocol)

    func viewDidLoad()

    func reloadData()

    func numberOfSections() -> Int

    func numberOfRowsInSection() -> Int

    func removeCounty(at indexPath: IndexPath)

    func fetchCounty(for indexPath: IndexPath) -> County?

    func presentAlert(at indexPath: IndexPath)

    func parseJSON()
    
}
