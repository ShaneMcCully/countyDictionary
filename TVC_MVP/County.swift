//
//  County.swift
//  TVC_MVP
//
//  Created by Shane McCully on 28/02/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

struct County {

    let countyID: Int
    let countyName: String
    let countyExtras: [String: Any]?

}

struct countyExtras {

    let population: Int
    let newBorns: Int

}
