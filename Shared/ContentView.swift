//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var monteCarlo = MonteCarloCalculator()
    
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        Button("Bruh", action: self.calculate)
            .padding()
            .frame(width: 100)
    }
    
    func calculate() {
        monteCarlo.monteCarloIntegrate(leftwavefunction: psi1s, rightwavefunction: psi1s, xMin: -10, yMin: -10, zMin: -10, xMax: 10, yMax: 10, zMax: 10, n: 10, spacing: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
