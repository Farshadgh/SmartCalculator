//
//  ResourceDatabase.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/4/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation

protocol ResourcesDataBase: BaseResourcesDataBase {
    func fetchFeatures() -> Void
    func fetchBitcoin() -> Void
    func fetchCoordinate(lat: Float, lon: Float) -> Void
}
