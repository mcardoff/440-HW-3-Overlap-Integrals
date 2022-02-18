//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    
    
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 1.0
        plotDataModel!.changingPlotParameters.yMin = -0.1
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -0.1
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red"{
            plotDataModel!.changingPlotParameters.lineColor = .red()
        }
        else{
            
            plotDataModel!.changingPlotParameters.lineColor = .blue()
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    @MainActor func appendDataToPlot(plotData: [plotDataType]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    func plotYEqualsX() async {
        await plotFunc(fun: {(x:Double) -> Double in return x}, funcName: "y = x", color: "Blue")
    }
    
    
    func ploteToTheMinusX() async {
        await plotFunc(fun: {(x:Double) -> (Double) in return exp(-x)}, funcName: "y = exp(-x)", color: "Red")
        return
    }
    
    func plotOverlapVsR(psil: (_:Double, _:Double, _:Double) -> Double,
                            psir: (_:Double, _:Double, _:Double) -> Double) async {
        await setThePlotParameters(color: "Red", xLabel: "R", yLabel: "Integral Value", title: "Integral Value vs R")
        await resetCalculatedTextOnMainThread()

        let monteCarlo = MonteCarloCalculator()
        await monteCarlo.setButtonEnable(state: false)
        // fix bounds of -10,10 for each dim
        let boxDim = 10.0, n = 100000
        var newPlotPts : [plotDataType] = []
        let range = stride(from: 0.0, to: 10, by: 0.1)
        for r in range {
            await monteCarlo.monteCarloIntegrate(
                leftwavefunction: psil, rightwavefunction: psir,
                xMin: -boxDim, yMin: -boxDim, zMin: -boxDim, xMax: boxDim, yMax: boxDim, zMax: boxDim,
                n: n, spacing: r)
            let tup : plotDataType = [.X: r, .Y: monteCarlo.integral]
            newPlotPts.append(tup)
        }
        
        await monteCarlo.updatePlotPts(content: newPlotPts)
        await monteCarlo.setButtonEnable(state: true)
        await appendDataToPlot(plotData: newPlotPts)
    }
    
    func plotFunc(fun: ((Double) -> Double), funcName: String, color: String) async {
        
        //set the Plot Parameters
        await setThePlotParameters(color: color, xLabel: "x", yLabel: funcName, title: funcName)
        await resetCalculatedTextOnMainThread()
        
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here
            let x = -2.0 + Double(i) * 0.2

            //create y values here
            let y = fun(x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        }
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
        return
    }
    
    
    @MainActor func resetCalculatedTextOnMainThread() {
        //Print Header
        plotDataModel!.calculatedText = ""
        
    }
    
    
    @MainActor func updateCalculatedTextOnMainThread(theText: String) {
        //Print Header
        plotDataModel!.calculatedText += theText
    }
    
}



