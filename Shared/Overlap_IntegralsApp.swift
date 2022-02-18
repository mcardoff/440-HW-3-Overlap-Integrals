//
//  Overlap_IntegralsApp.swift
//  Shared
//
//  Created by Michael Cardiff on 2/16/22.
//

import SwiftUI

@main
struct Overlap_IntegralsApp: App {
    
//    @StateObject var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1000, height: 800)
                .tabItem {
                    Text("Basic Image")
                }
//            drawingView(redLayer: <#T##Binding<[(x: Double, y: Double)]>#>, blueLayer: <#T##Binding<[(x: Double, y: Double)]>#>)
//                .tabItem {
//                    Text("Plot")
//                }
        }
    }
}
