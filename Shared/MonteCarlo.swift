//
//  MonteCarlo.swift
//  Overlap Integraps
//
//  Created by Michael Cardiff on 2/16/22.
//

import Foundation
import SwiftUI

// use the average value theorem to compute the value of the overlap integral of two wavefunctions

typealias CoordTuple = (x: Double, y: Double)

class MonteCarloCalculator: NSObject, ObservableObject {
    
    @Published var integral = 0.0 // value of calculated integral
    @Published var integralString = "" // value of calculated integral but a string :)
    @Published var redPoints : [CoordTuple] = []
    @Published var bluPoints : [CoordTuple] = []
    @Published var enableButton = true
    //    @Published var normalized = false
    
    
    /// monteCarloIntegrate
    ///
    /// updates class with data by performing a monte carlo simulation
    ///
    /// - Parameters:
    ///    -  leftWavefunction: Function that is on the "left" side of the overlap
    ///    - rightWavefunction: Function on the "right" side of the overlap
    ///    - iMin: minimum for 'i' dimension, i = x,y,z
    ///    - iMax: maximum for 'i' dimension, i = x,y,z
    ///    - n: Number of points to use in the Monte Carlo simulation
    ///    - spacing: Interatomic spacing R
    func monteCarloIntegrate(leftwavefunction:  (_ : Double, _ : Double, _ : Double) -> Double,
                             rightwavefunction: (_ : Double, _ : Double, _ : Double) -> Double,
                             xMin: Double, yMin: Double, zMin: Double, xMax: Double, yMax: Double, zMax: Double,
                             n: Int, spacing: Double ) async {
        var tempRedPoints : [CoordTuple] = []
        var tempBluPoints : [CoordTuple] = []
        var LHV = 0.0, RHV = 0.0
        var funVals : [Double] = []
        let offset = spacing
        for _ in 1...n { // n random points
            
            var xCur = Double.random(in: xMin...xMax)
            var yCur = Double.random(in: yMin...yMax)
            let zCur = Double.random(in: zMin...zMax)
            
            // ensure no undefined behavior for phi
            if xCur == 0 && yCur == 0.0 {
                xCur = 0.00001
                yCur = 0.00001
            }
            
            LHV = leftwavefunction(xCur - (offset/2), yCur, zCur) // left is at x - R
            RHV = rightwavefunction(xCur + (offset/2), yCur, zCur) // right is at x + R
            let prod = LHV * RHV
            
            funVals.append(prod)
            let tuple = (x: xCur, y: yCur)
            if(tempRedPoints.count + tempBluPoints.count < 50000) {
                if(prod < 0.0) { // negative is blue
                    tempBluPoints.append(tuple)
                } else {
                    tempRedPoints.append(tuple)
                }
            }
            
        }
        
        // silly little test
        assert(funVals.count == n)
//        if !normalized {
//            normalizePts() // adjusts red/blue to be between 0,1
//            normalized = true
//        }
        
        let vol = await BoundingBox.volumeFromCoords(x1: xMin, x2: xMax, y1: yMin, y2: yMax, z1: zMin, z2: zMax)
        let avg = await calculateAverage(data: funVals)
        await updatePoints(blu: tempBluPoints, red: tempRedPoints)
        await updateIntegral(val: avg * vol)
        await updateIntegralString(text: String(self.integral))
    }
    
    /// updatePoints
    ///
    /// Updates class variables from main thread
    ///
    @MainActor func updatePoints(blu: [CoordTuple], red: [CoordTuple]) {
        bluPoints.append(contentsOf: blu)
        redPoints.append(contentsOf: red)
    }
    
    /// updateIntegral
    ///
    /// Updates class variables from main thread
    ///
    @MainActor func updateIntegral(val: Double) async {
        self.integral = val
    }
    
    /// updateIntegralString
    ///
    /// Updates class variables from main thread
    ///
    @MainActor func updateIntegralString(text: String) async {
        self.integralString = text
    }
    
    /// calculateAverage
    ///
    /// Finds the average of the elements in a list, using the fact that we have asserted that the number of items in the list is same as number of points
    ///
    /// - Parameter data: The data to average
    func calculateAverage(data: [Double]) async -> Double {
        var sum = 0.0
        for num in data {
            sum += num
        }
        return sum / Double(data.count)
    }
    
    /// calculateAverage
    ///
    /// Finds the average of the elements in a list, using the fact that we have asserted that the number of items in the list is same as number of points
    ///
    /// - Parameters:
    ///    - data: The data to sum over
    ///    - nPts: Factor to divide over
    func calculateAverage(data: [Double], nPts: Int) -> Double {
        var sum = 0.0
        for num in data {
            sum += num
        }
        let avg = sum / Double(nPts)
        return avg
    }
    
    /// clearData
    ///
    /// Removes points in class variables to clear the plot on screen
    func clearData() {
        bluPoints.removeAll()
        redPoints.removeAll()
    }
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    
    // used temporarily to attempt to get a good looking plot, but I realized that kind of was the wrong idea
    func normalizePts() {
        var maxX : Double = -Double.greatestFiniteMagnitude // effectively -infinity
        var maxY : Double = -Double.greatestFiniteMagnitude // effectively -infinity
        var newRedList : [CoordTuple] = []
        var newBluList : [CoordTuple] = []
        let combinedList = redPoints + bluPoints
        
        for tup in combinedList { // finds max of entire thing
            // maxes
            if tup.x > maxX {
                maxX = tup.x
            }
            
            if tup.y > maxY {
                maxY = tup.y
            }
        }
        
        let globalMax = max(maxX, maxY)
        // found maximum and minimum x and y, now we can reduce to a max of 1
        for tup in redPoints {
            let newTup = (x: tup.x / globalMax, y: tup.y / globalMax)
            newRedList.append(newTup)
        }
        
        for tup in bluPoints {
            let newTup = (x: tup.x / globalMax, y: tup.y / globalMax)
            newBluList.append(newTup)
        }
        
        redPoints = newRedList
        bluPoints = newBluList
    }
}
