//
//  LocalizedError.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/5/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    
    case invalidData
     
    var description: String? {
        switch self {
        case .invalidData:
            return "Parsing error, something bad has happened"
        }
    }

}
