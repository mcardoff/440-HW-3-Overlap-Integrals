//
//  PlotView.swift
//  Shared
//
//  Created by Jeff Terry on 1/25/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotData :PlotClass
    
    @ObservedObject private var calculator = CalculatePlotData()
    @State var isChecked:Bool = false
    @State var tempInput = ""
    
    @State var selector = 0

    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotData.plotArray[selector].plotData, changingPlotParameters: $plotData.plotArray[selector].changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            /*
                     CorePlot(dataForPlot: $plotData.plotArray[0].plotData, changingPlotParameters: $plotData.plotArray[0].changingPlotParameters)
                         .setPlotPadding(left: 10)
                         .setPlotPadding(right: 10)
                         .setPlotPadding(top: 10)
                         .setPlotPadding(bottom: 10)
                         .padding()
                     
                     Divider()
                     */
   /*
            CorePlot(dataForPlot: $plotData.plotArray[1].plotData, changingPlotParameters: $plotData.plotArray[1].changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            */
            HStack{
                
                HStack(alignment: .center) {
                    Text("temp:")
                        .font(.callout)
                        .bold()
                    TextField("temp", text: $tempInput)
                        .padding()
                }.padding()
                
                Toggle(isOn: $isChecked) {
                            Text("Display Error")
                        }
                .padding()
                
                
            }
            
            
            HStack{
                Button("exp(-x)", action: {
                    
                    Task.init{
                    
                    self.selector = 0
                    await self.calculate()
                    }
                    
                    
                    
                }
                
                
                )
                .padding()
                
            }
            
            HStack{
                Button("x", action: { Task.init{
                    
                    self.selector = 1
                    
                    await self.calculate2()
                    
                    
                }
                }
                
                
                )
                .padding()
                
            }
            
        }
        
    }
    
    @MainActor func setupPlotDataModel(selector: Int){
        
        calculator.plotDataModel = self.plotData.plotArray[selector]
    }
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate() async {
        
        //pass the plotDataModel to the Calculator
       // calculator.plotDataModel = self.plotData.plotArray[0]
        
        setupPlotDataModel(selector: 0)
        
     //   Task{
            
            
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in



                taskGroup.addTask {

        
        var temp = 0.0
        
        
        
        //Calculate the new plotting data and place in the plotDataModel
        await calculator.ploteToTheMinusX()
        
                    // This forces a SwiftUI update. Force a SwiftUI update.
        await self.plotData.objectWillChange.send()
                    
                }

                
            }
            
  //      }
        
        
    }
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate2() async {
        
        
        //pass the plotDataModel to the Calculator
       // calculator.plotDataModel = self.plotData.plotArray[0]
        
        setupPlotDataModel(selector: 1)
        
     //   Task{
            
            
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in



                taskGroup.addTask {

        
        var temp = 0.0
        
        
        
        //Calculate the new plotting data and place in the plotDataModel
        await calculator.plotYEqualsX()
                  
                    // This forces a SwiftUI update. Force a SwiftUI update.
        await self.plotData.objectWillChange.send()
                    
                }
                
            }
            
    //    }
        
        

    }
    

   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
