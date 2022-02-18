//
//  DrawingView.swift

//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//

import SwiftUI

struct drawingView: View {
    
//    @Binding var redLayer  : [(x: Double, y: Double)]
//    @Binding var blueLayer : [(x: Double, y: Double)]
    @Binding var redLayer1 : [CoordTuple]
    @Binding var redLayer2 : [CoordTuple]
    @Binding var redLayer3 : [CoordTuple]
    @Binding var redLayer4 : [CoordTuple]
    @Binding var redLayer5 : [CoordTuple]
    @Binding var redLayer6 : [CoordTuple]
    @Binding var bluLayer1 : [CoordTuple]
    @Binding var bluLayer2 : [CoordTuple]
    @Binding var bluLayer3 : [CoordTuple]
    @Binding var bluLayer4 : [CoordTuple]
    @Binding var bluLayer5 : [CoordTuple]
    @Binding var bluLayer6 : [CoordTuple]
    
    var body: some View {
        
        
        ZStack{
            // red
            Group {
                drawIntegral(drawingPoints: redLayer6)
                    .stroke(Color(red: 1.0, green: 0, blue: 0))
                drawIntegral(drawingPoints: redLayer5)
                    .stroke(Color(red: 1.0, green: 91.0/255.0, blue: 0))
                drawIntegral(drawingPoints: redLayer4)
                    .stroke(Color(red: 1.0, green: 138.0/255.0, blue: 0))
                drawIntegral(drawingPoints: redLayer3)
                    .stroke(Color(red: 1.0, green: 179.0/255.0, blue: 0))
                drawIntegral(drawingPoints: redLayer2)
                    .stroke(Color(red: 1.0, green: 218.0/255.0, blue: 0))
                drawIntegral(drawingPoints: redLayer1)
                    .stroke(Color(red: 1.0, green: 1.0, blue: 0))
            }
            // blue
            Group {
                drawIntegral(drawingPoints: bluLayer1)
                    .stroke(Color(red: 0, green: 0, blue: 1.0))
                drawIntegral(drawingPoints: bluLayer2)
                    .stroke(Color(red: 0, green: 121.0/255.0, blue: 1.0))
                drawIntegral(drawingPoints: bluLayer3)
                    .stroke(Color(red: 0, green: 168.0/255.0, blue: 1.0))
                drawIntegral(drawingPoints: bluLayer4)
                    .stroke(Color(red: 0, green: 202.0/255.0, blue: 249.0/255.0))
                drawIntegral(drawingPoints: bluLayer5)
                    .stroke(Color(red: 0, green: 233.0/255.0, blue: 146.0/255/0))
                drawIntegral(drawingPoints: bluLayer6)
                    .stroke(Color(red: 0, green: 1.0, blue: 0))
            }
            
        }
        .background(Color.black)
        .aspectRatio(1, contentMode: .fill)
        
    }
}


struct drawIntegral: Shape {
    let smoothness : CGFloat = 1.0
    var drawingPoints: [(x: Double, y: Double)]  ///Array of tuples
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let scale = rect.width / 10
        
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
}
