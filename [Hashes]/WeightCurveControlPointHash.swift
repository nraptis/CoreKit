//
//  WeightCurvePointHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/13/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct WeightCurvePointHash: Equatable {//}, Hashable {
    
    public init() {
        
    }
    
    public var normalizedTanDirection = Float(0.0)
    public var normalizedTanMagnitudeIn = Float(0.0)
    public var normalizedTanMagnitudeOut = Float(0.0)
    public var isManualHeightEnabled = false
    public var normalizedHeightFactor = Float(0.0)
    public var isManualTanHandleEnabled = false
    public mutating func change(
        normalizedTanDirection: Float,
        normalizedTanMagnitudeIn: Float,
        normalizedTanMagnitudeOut: Float,
        isManualHeightEnabled: Bool,
        normalizedHeightFactor: Float,
        isManualTanHandleEnabled: Bool) {
            self.normalizedTanDirection = normalizedTanDirection
            self.normalizedTanMagnitudeIn = normalizedTanMagnitudeIn
            self.normalizedTanMagnitudeOut = normalizedTanMagnitudeOut
            self.isManualHeightEnabled = isManualHeightEnabled
            self.normalizedHeightFactor = normalizedHeightFactor
            self.isManualTanHandleEnabled = isManualTanHandleEnabled
        }
    
    public mutating func invalidate() {
        normalizedTanDirection = Float(0.0)
        normalizedTanMagnitudeIn = Float(0.0)
        normalizedTanMagnitudeOut = Float(0.0)
        isManualHeightEnabled = false
        normalizedHeightFactor = Float(0.0)
        isManualTanHandleEnabled = false
    }
    
}
