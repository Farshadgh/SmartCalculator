//
//  FirebaseServices.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/4/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Resolver
import SwiftUI

class BaseResourcesDataBase {
    @Published var feature: FeatureModel?
    @Published var bitcoin: Float = 0
    @Published var resError: AppError?
    @Published var location: String?
}



class FirebaseService:  BaseResourcesDataBase, ResourcesDataBase, ObservableObject {

    
    @Injected var database: Firestore

    override init() {
        super.init()
        
        fetchBitcoin()
        fetchFeatures()
    }
    
    func fetchCoordinate(lat: Float, lon: Float) {
        let ref = database.collection("calculator").document("location")
        ref.getDocument { doc, error  in
            guard error == nil else {
                self.resError = error as? AppError
                return
            }
            guard let doc = doc, let dic = doc.data() else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let location = try JSONDecoder().decode(LocationModel.self, from: data)
                self.location = location.name
                
                
            } catch {
                self.resError = AppError.invalidData
            }
        }
    }
    
    func fetchFeatures() {
        
        let ref = database.collection("calculator").document("feature")
        ref.getDocument { doc, error  in
            guard error == nil else {
                self.resError = error as? AppError
                return
            }
            guard let doc = doc, let dic = doc.data() else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = try JSONDecoder().decode(FeatureModel.self, from: data)
                self.feature = model
                
            } catch {
                self.resError = AppError.invalidData
            }
        }
    }
    
    func fetchBitcoin() {
        let ref = database.collection("calculator").document("bitcoin")
        ref.getDocument { doc, error  in
            guard error == nil else {
                self.resError = error as? AppError
                return
            }
            guard let doc = doc, let dic = doc.data() else { return }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                let model = try JSONDecoder().decode(BitcoinModel.self, from: data)
                self.bitcoin = model.rate
                
            } catch {
                self.resError = AppError.invalidData 
            }
        }
    }

}
