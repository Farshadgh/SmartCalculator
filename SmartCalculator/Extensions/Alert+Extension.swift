//
//  Alert+Extension.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/5/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI

extension Alert {
    init(localizedError: AppError?) {
        self = Alert(title: Text(localizedError?.description ?? "Unknown Error"),
                     message: nil,
                     dismissButton: .default(Text("OK")))

    }
     
}
