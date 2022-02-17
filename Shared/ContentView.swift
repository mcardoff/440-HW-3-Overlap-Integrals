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
        VStack {
            Text("Bruh Moment")
            TextField("Integral Value", text: $monteCarlo.integralString)
                .padding()
                .frame(width: 100)
        }
        Button("Bruh", action: self.calculate)
            .padding()
            .frame(width: 100)
    }
    
    func calculate() {
        let boxSide = 2.0 // small for now
        monteCarlo.monteCarloIntegrate(leftwavefunction: psi1s, rightwavefunction: psi1s, xMin: -boxSide, yMin: -boxSide, zMin: -boxSide, xMax: boxSide, yMax: boxSide, zMax: boxSide, n: 100000, spacing: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
