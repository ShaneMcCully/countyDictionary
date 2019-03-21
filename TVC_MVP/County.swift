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
    var countyExtras: CountyExtras?

    init(countyID: Int, countyName: String) {
        self.countyID = countyID
        self.countyName = countyName
    }

    func hasExtras() -> Bool {
        return countyExtras != nil
    }
    
}

struct CountyExtras {

    var population: Int?
    var newBorns: Int?

    init(population: Int = 0, newBorns: Int = 0) {
        self.population = population
        self.newBorns = newBorns
    }

}
