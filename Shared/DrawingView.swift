//
//  DrawingView.swift
//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//

import SwiftUI

struct drawingView: View {
    
    @Binding var redLayer : [(x: Double, y: Double)]
    @Binding var blueLayer : [(x: Double, y: Double)]
    
    var body: some View {
        
        
        ZStack{
            drawIntegral(drawingPoints: redLayer )
                .stroke(Color.red)
            
            drawIntegral(drawingPoints: blueLayer )
                .stroke(Color.blue)
        }
        .background(Color.black)
        .aspectRatio(1, contentMode: .fill)
        
    }
}


struct drawIntegral: Shape {
    let smoothness : CGFloat = 1.0
    var drawingPoints: [(x: Double, y: Double)]  ///Array of tuples
    
    func path(in rect: CGRect) -> Path {
        // draw from the center of our rectangle
        
        //normalizePts()
        let center = CGPoint(x: 0, y: rect.height)
        let scale = rect.width/10
        
        // Create the Path for the display
        var path = Path()
        for item in drawingPoints {
            path.addRect(CGRect(
                x: item.x*Double(scale)+Double(center.x),
                y: -item.y*Double(scale)+Double(center.y),
                width: 1.0 , height: 1.0))
        }
        return (path)
    }
    
    func normalizePts() {
        var maxX : Double = -Double.greatestFiniteMagnitude // effectively -infinity
        var maxY : Double = -Double.greatestFiniteMagnitude // effectively -infinity
        for tup in drawingPoints {
            if tup.x > maxX {
                maxX = tup.x
            }
        }
    }
}
