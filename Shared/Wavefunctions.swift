//
//  Wavefunctions.swift
//  Overlap Integraps
//
//  Created by Michael Cardiff on 2/16/22.
//

import SwiftUI


/// psi1s
///
/// 1s orbital in rectangular coordinates
///
func psi1s(x: Double, y: Double, z: Double) -> Double {
    let r = sqrt(x*x + y*y + z*z)
    let phi = atan2(y,x)
    let theta = acos(z/r)
    return psi1sSph(r: r, theta: theta, phi: phi)
}

/// psi2px
///
/// 2px orbital in rectangular coordinates
///
func psi2px(x: Double, y: Double, z: Double) -> Double {
    let r = sqrt(x*x + y*y + z*z)
    let phi = atan2(y,x)
    let theta = acos(z/r)
    return psi2pxSph(r: r, theta: theta, phi: phi)
}

/// psi1sSph
///
/// 1s orbital in spherical coordinates
///
func psi1sSph(r: Double, theta: Double, phi: Double) -> Double {
    let coeff = 1.0 / sqrt(Double.pi)
    let expon = exp(-r)
    return coeff * expon
}

/// psi2pxSph
///
/// 2px orbital in spherical coordinates
///
func psi2pxSph( r: Double, theta: Double, phi: Double) -> Double {
    let coeff = 1.0 / (4.0 * sqrt(2.0 * Double.pi))
    let linear = r
    let expon = exp(-r / (2.0))
    let ang = sin(theta) * cos(phi)
    return coeff * linear * expon * ang
}
