//
//  CalculatorView.swift
//  SmartCalculator
//
//  Created by Farshad Ghafari on 8/2/20.
//  Copyright © 2020 Farshad Ghafari. All rights reserved.
//

import SwiftUI
import Resolver


struct CalculatorView: View {
    
    @ObservedObject var viewModel: CalculatorViewModel
    
    var style: AppTheme {
        return AppKit.Styles.Default
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                self.style.backgroundColor
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack() {
                
                DisplayView(style: self.style)
                    .padding([.horizontal, .top])
                    .environmentObject(self.viewModel)
                
                Divider()
                    .padding(.horizontal)
                
                
                LogicPad(style: self.style)
                    
                    .frame(height: geometry.size.height * 0.2)
                    .padding([.top, .bottom], 5)
                    .padding([.trailing, .leading])
                    .scaleEffect(1)
                    .animation(.easeInOut(duration: 0.2))
                    .environmentObject(self.viewModel)
                
                
                
                NumPadView(style: self.style)
                    .padding([.leading, .trailing])
                    .scaleEffect(1)
                    .animation(.easeInOut(duration: 0.2))
                    .environmentObject(self.viewModel)
                
                
            }.padding([.top, .bottom])
                .background(self.style.backgroundColor)
            

        }
        .alert(isPresented: viewModel.isPresentingAlert){
            Alert(localizedError: viewModel.resError)
        }
        
    }
}



struct CalculatorView_Previews: PreviewProvider {
    static let calculator = Calculator()
    static var previews: some View {
        CalculatorView(viewModel: Resolver.resolve())
    }
}
