//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 2/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var monteCarlo = MonteCarloCalculator()
    @State var nString = "100000"
    @State var xMinString = "-5.0"
    @State var yMinString = "-5.0"
    @State var zMinString = "-5.0"
    @State var xMaxString = "5.0"
    @State var yMaxString = "5.0"
    @State var zMaxString = "5.0"
    @State var spacingString = "0.0"
    @State var leftFuncString = ""
    @State var rightFuncString = ""
    var orbitals = ["1s", "2px"]
    
    var body: some View {
        HStack {
            VStack {
                VStack {
                    Text("Number of Points")
                    TextField("Make it big!", text: $nString, onCommit: self.calculate)
                        .frame(width: 100)
                }.padding()
                
                VStack {
                    Text("X Limits")
                    HStack {
                        // x dims
                        TextField("X Min", text: $xMinString)
                            .frame(width: 75)
                        TextField("X Max", text: $xMaxString)
                            .frame(width: 75)
                    }
                    
                    Text("Y Limits")
                    HStack {
                        // y dims
                        TextField("Y Min", text: $yMinString)
                            .frame(width: 75)
                        TextField("Y Max", text: $yMaxString)
                            .frame(width: 75)
                    }
                    
                    Text("Z Limits")
                    HStack {
                        // z dims
                        TextField("Z Min", text: $zMinString)
                            .frame(width: 75)
                        TextField("Z Max", text: $zMaxString)
                            .frame(width: 75)
                    }
                }.padding()
                
                VStack {
                    Text("Interatmoic Spacing")
                    TextField("R", text: $spacingString)
                        .frame(width: 100)
                }.padding()
                
                VStack {
                    Text("Choose Left Wavefunc")
                    Picker("", selection: $leftFuncString) {
                        ForEach(orbitals, id: \.self) {
                            Text($0)
                        }
                    }.frame(width: 100)
                }.padding()
                
                VStack {
                    Text("Choose Right Wavefunc")
                    Picker("", selection: $rightFuncString) {
                        ForEach(orbitals, id: \.self) {
                            Text($0)
                        }
                    }.frame(width: 100)
                }.padding()
                
                VStack {
                    Text("Integral Value")
                    TextField("Integral Value", text: $monteCarlo.integralString)
                        .frame(width: 100)
                }.padding()
                
                Button("Integrate", action: self.calculate)
                    .padding()
                    .frame(width: 150)
                    .disabled(monteCarlo.enableButton == false)
                
                Button("Clear", action: self.clear)
                    .padding()
                    .frame(width: 100)
            }
            // DrawingField
            drawingView(redLayer: $monteCarlo.redPoints, blueLayer: $monteCarlo.bluPoints)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
        }
    }
    
    func calculate() {
        //        let boxSide = 5.0 // small for now
        // trusting the user for now
        let xMin = Double(xMinString)!, yMin = Double(yMinString)!, zMin = Double(zMinString)!,
            xMax = Double(xMaxString)!, yMax = Double(yMaxString)!, zMax = Double(zMaxString)!
        let spacing = Double(spacingString)!
        var func1 = psi1s, func2 = psi1s
        
        // left func
        if (leftFuncString == "2px") {
            func1 = psi2px
            print("Changed left func to 2px!")
        } else {
            func1 = psi1s
            print("Changed left func to 1s")
        }
        
        // right func
        if (rightFuncString == "2px") {
            func2 = psi2px
            print("Changed right func to 2px!")
        } else {
            func2 = psi1s
            print("Changed right func to 1s!")
        }
        
        monteCarlo.monteCarloIntegrate(
            leftwavefunction: func1, rightwavefunction: func2,
            xMin: xMin, yMin: yMin, zMin: zMin, xMax: xMax, yMax: yMax, zMax: zMax,
            n: Int(nString)!, spacing: spacing)
    }
    
    func clear() {
        monteCarlo.clearData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
