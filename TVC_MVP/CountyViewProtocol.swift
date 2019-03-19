//
//  CountyViewProtocol.swift
//  TVC_MVP
//
//  Created by Shane McCully on 14/03/2019.
//  Copyright © 2019 Shane McCully. All rights reserved.
//

import Foundation

protocol CountyViewProtocol: class {

    func reloadData()

    func presentAlert(title: String, message: String, action: (() -> Void)?)

}
