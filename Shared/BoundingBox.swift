//
//  BoundingBox.swift
//  Monte Carlo Integration
//
//  Created by Jeff Terry on 12/31/20.
//

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    
    /// calculateVolume
    ///
    /// - Parameters:
    ///   - lengthOfSide1: length of the first side
    ///   - lengthOfSide2: length of the second side
    ///   - lengthOfSide3: length of the third side
    /// - Returns: returns the volume of a box
    @MainActor static func calculateVolume(lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) async -> Double {
        return (lengthOfSide1*lengthOfSide2*lengthOfSide3)
    }
    
    static func volumeFromCoords(x1: Double, x2: Double, y1: Double, y2: Double, z1: Double, z2: Double) async -> Double {
        let lenX = max(x1,x2)-min(x1,x2)
        let lenY = max(y1,y2)-min(y1,y2)
        let lenZ = max(z1,z2)-min(z1,z2)
        return await BoundingBox.calculateVolume(lengthOfSide1: lenX, lengthOfSide2: lenY, lengthOfSide3: lenZ)
    }
    
    /// calculateSurfaceArea
    ///
    /// - Parameters:
    ///   - numberOfSides: number of sides of the box
    ///   - lengthOfSide1: length of the first side
    ///   - lengthOfSide2: length of the second side
    ///   - lengthOfSide3: length of the third side
    /// - Returns: returns the surface area of the box
    func calculateSurfaceArea(numberOfSides: Int, lengthOfSide1: Double, lengthOfSide2: Double, lengthOfSide3: Double) -> Double {
        
        var surfaceArea = 0.0
        if numberOfSides == 2 {
            surfaceArea = lengthOfSide1*lengthOfSide2
        } else if numberOfSides == 6 {
            surfaceArea = 2*lengthOfSide1*lengthOfSide2 + 2*lengthOfSide2*lengthOfSide3 + 2*lengthOfSide1*lengthOfSide3
        } else {
            surfaceArea = 0.0
        }
        return (surfaceArea)
    }

}

