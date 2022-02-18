//
//  Wavefunctions.swift
//  Overlap Integraps
//
//  Created by Michael Cardiff on 2/16/22.
//

import SwiftUI

func psi1s(x: Double, y: Double, z: Double) -> Double {
    let r = sqrt(x*x + y*y + z*z)
    let phi = convertPhi(x: x, y: y, z: z)
    let theta = acos(z/r)
    return psi1sSph(r: r, theta: theta, phi: phi)
}

func psi2px(x: Double, y: Double, z: Double) -> Double {
    let r = sqrt(x*x + y*y + z*z)
    let phi = convertPhi(x: x, y: y, z: z)
    let theta = acos(z/r)
    return psi2pxSph(r: r, theta: theta, phi: phi)
}

func psi1sSph(r: Double, theta: Double, phi: Double) -> Double {
    let coeff = 1.0 / sqrt(Double.pi)
    let expon = exp(-r)
    return coeff * expon
}

func psi2pxSph( r: Double, theta: Double, phi: Double) -> Double {
    let coeff = 1.0 / (4.0 * sqrt(2.0 * Double.pi))
    let linear = r
    let expon = exp(-r / (2.0))
    let ang = sin(theta) * cos(phi)
    return coeff * linear * expon * ang
}

func convertPhi(x: Double, y: Double, z: Double) -> Double {
    if (x > 0) {
        return atan(y/x)
    } else if (x < 0 && y >= 0) {
        return atan(y/x) + Double.pi
    } else if (x < 0 && y < 0) {
        return atan(y/x) - Double.pi
    } else if (x == 0 && y > 0) {
        return Double.pi / 2
    } else if (x == 0 && y < 0) {
        return -Double.pi / 2
    } else {
        return -1
    }
}
