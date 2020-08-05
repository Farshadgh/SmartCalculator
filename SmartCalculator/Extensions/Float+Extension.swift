//
//  Float+Extension.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/3/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
