//
//  WeightCurveHash.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 7/13/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public struct WeightCurveHash: Equatable {
    
    public init() {
        
    }
    
    public var frameWidth: Float = 0.0
    public var frameHeight: Float = 0.0
    public var paddingH: Float = 0.0
    public var paddingV: Float = 0.0
    public var weightCurvePointStart = WeightCurvePointHash()
    public var weightCurvePointMiddle = WeightCurvePointHash()
    public var weightCurvePointEnd = WeightCurvePointHash()
    
    public mutating func change(graphFrame: GraphFrame,
                                weightCurvePointStart: WeightCurvePoint,
                                weightCurvePointMiddle: WeightCurvePoint,
                                weightCurvePointEnd: WeightCurvePoint) {
        
        self.frameWidth = graphFrame.width
        self.frameHeight = graphFrame.height
        self.paddingH = graphFrame.paddingH
        self.paddingV = graphFrame.paddingV
        
        self.weightCurvePointStart.change(normalizedTanDirection: weightCurvePointStart.normalizedTanDirection,
                                                 normalizedTanMagnitudeIn: weightCurvePointStart.normalizedTanMagnitudeIn,
                                                 normalizedTanMagnitudeOut: weightCurvePointStart.normalizedTanMagnitudeOut,
                                                 isManualHeightEnabled: weightCurvePointStart.isManualHeightEnabled,
                                                 normalizedHeightFactor: weightCurvePointStart.normalizedHeightFactor,
                                                 isManualTanHandleEnabled: weightCurvePointStart.isManualTanHandleEnabled)
        
        self.weightCurvePointMiddle.change(normalizedTanDirection: weightCurvePointMiddle.normalizedTanDirection,
                                                         normalizedTanMagnitudeIn: weightCurvePointMiddle.normalizedTanMagnitudeIn,
                                                         normalizedTanMagnitudeOut: weightCurvePointMiddle.normalizedTanMagnitudeOut,
                                                         isManualHeightEnabled: weightCurvePointMiddle.isManualHeightEnabled,
                                                         normalizedHeightFactor: weightCurvePointMiddle.normalizedHeightFactor,
                                                         isManualTanHandleEnabled: weightCurvePointMiddle.isManualTanHandleEnabled)
        
        self.weightCurvePointEnd.change(normalizedTanDirection: weightCurvePointEnd.normalizedTanDirection,
                                               normalizedTanMagnitudeIn: weightCurvePointEnd.normalizedTanMagnitudeIn,
                                               normalizedTanMagnitudeOut: weightCurvePointEnd.normalizedTanMagnitudeOut,
                                               isManualHeightEnabled: weightCurvePointEnd.isManualHeightEnabled,
                                               normalizedHeightFactor: weightCurvePointEnd.normalizedHeightFactor,
                                               isManualTanHandleEnabled: weightCurvePointEnd.isManualTanHandleEnabled)
        
    }
    
    public mutating func invalidate() {
        frameWidth = 0.0
        frameHeight = 0.0
        paddingH = 0.0
        paddingV = 0.0
        weightCurvePointStart.invalidate()
        weightCurvePointMiddle.invalidate()
        weightCurvePointEnd.invalidate()
    }
    
}

