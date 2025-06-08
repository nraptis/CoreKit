//
//  GraphAttributeDataWholePoint.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/2/25.
//

import Foundation

public struct GraphAttributeDataControlPoint {
    public let normalizedHeightFactor: Float
    public let isManualHeightEnabled: Bool
    public let normalizedTanDirection: Float
    public let normalizedTanMagnitudeIn: Float
    public let normalizedTanMagnitudeOut: Float
    public let isManualTanHandleEnabled: Bool
    public init(normalizedHeightFactor: Float,
                isManualHeightEnabled: Bool,
                normalizedTanDirection: Float,
                normalizedTanMagnitudeIn: Float,
                normalizedTanMagnitudeOut: Float,
                isManualTanHandleEnabled: Bool) {
        self.normalizedHeightFactor = normalizedHeightFactor
        self.isManualHeightEnabled = isManualHeightEnabled
        self.normalizedTanDirection = normalizedTanDirection
        self.normalizedTanMagnitudeIn = normalizedTanMagnitudeIn
        self.normalizedTanMagnitudeOut = normalizedTanMagnitudeOut
        self.isManualTanHandleEnabled = isManualTanHandleEnabled
    }
}
