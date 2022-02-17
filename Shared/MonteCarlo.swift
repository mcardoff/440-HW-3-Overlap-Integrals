//
//  MonteCarlo.swift
//  Overlap Integraps
//
//  Created by Michael Cardiff on 2/16/22.
//

import Foundation
import SwiftUI

class MonteCarloCalculator: NSObject, ObservableObject {
    
    func monteCarloIntegrate(leftwavefunction:  (_ : Double, _ : Double, _ : Double) -> Double,
                             rightwavefunction: (_ : Double, _ : Double, _ : Double) -> Double) {
        let offset = 0.0
        while (1 < 0) {
            // box hardcoded to -10,10 on each side
            let xCur = Double.random(in: -10...10)
            let yCur = Double.random(in: -10...10)
            let zCur = Double.random(in: -10...10)
            
            let LHV = leftwavefunction(xCur, yCur, zCur)
        }
    }
    
    func calculateAverage(data: [Double], nPts: Int) -> Double {
        var sum = 0.0
        for num in data {
            sum += num
        }
//        \frac{1}{2}
        let avg = sum / Double(nPts)
        return avg
    }
}
