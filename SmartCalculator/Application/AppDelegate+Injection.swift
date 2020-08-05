//
//  AppDelegate+Injection.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 5.08.2020.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        
        register { Firestore.firestore() }.scope(application)
        register { FirebaseService() as ResourcesDataBase }.scope(application)
        register { CalculatorViewModel() }.scope(application)
        register { Calculator() }.scope(application)

    }
}
