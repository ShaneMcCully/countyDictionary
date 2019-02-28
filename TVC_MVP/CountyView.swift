//
//  CountyView.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

protocol CountyView: class {

    func parseJSON() -> [County]

    func presentAlert(county: County)
    
}


// View - protocol that view controller conforms to - anything thats here needs to be implemented in the VC
