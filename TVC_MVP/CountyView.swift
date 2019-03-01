//
//  CountyView.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

protocol CountyView: class {

    func parseJSON()

    func presentAlert(county: County)
    
}

