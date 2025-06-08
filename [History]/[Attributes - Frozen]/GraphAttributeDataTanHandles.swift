//
//  GraphAttributeDataTanHandles.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public struct GraphAttributeDataTanHandles {
    
    public let normalizedTanDirection: Float
    public let normalizedTanMagnitudeIn: Float
    public let normalizedTanMagnitudeOut: Float
    public let isManualTanHandleEnabled: Bool
    
    public init(normalizedTanDirection: Float, normalizedTanMagnitudeIn: Float, normalizedTanMagnitudeOut: Float, isManualTanHandleEnabled: Bool) {
        self.normalizedTanDirection = normalizedTanDirection
        self.normalizedTanMagnitudeIn = normalizedTanMagnitudeIn
        self.normalizedTanMagnitudeOut = normalizedTanMagnitudeOut
        self.isManualTanHandleEnabled = isManualTanHandleEnabled
    }
}
