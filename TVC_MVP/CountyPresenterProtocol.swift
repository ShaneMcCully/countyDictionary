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

    func numberOfSections() -> Int

    func numberOfRowsInSection() -> Int

    func getObject(at indexPath: IndexPath) -> County?

    func didSelectRow(indexPath: IndexPath)
    
}
