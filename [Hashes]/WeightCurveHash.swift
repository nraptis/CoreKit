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
    public var weightCurvePoints = [WeightCurvePointHash]()
    public var weightCurvePointEnd = WeightCurvePointHash()
    
    public mutating func change(frameWidth: Float,
                                frameHeight: Float,
                                paddingH: Float,
                                paddingV: Float,
                                weightCurvePointStart: WeightCurvePoint,
                                owningList: [Guide],
                                owningListCount: Int,
                                weightCurvePointEnd: WeightCurvePoint) {
        
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        
        self.paddingH = paddingH
        self.paddingV = paddingV
        
        self.weightCurvePointStart.change(normalizedTanDirection: weightCurvePointStart.normalizedTanDirection,
                                                 normalizedTanMagnitudeIn: weightCurvePointStart.normalizedTanMagnitudeIn,
                                                 normalizedTanMagnitudeOut: weightCurvePointStart.normalizedTanMagnitudeOut,
                                                 isManualHeightEnabled: weightCurvePointStart.isManualHeightEnabled,
                                                 normalizedHeightFactor: weightCurvePointStart.normalizedHeightFactor,
                                                 isManualTanHandleEnabled: weightCurvePointStart.isManualTanHandleEnabled)
        
        if weightCurvePoints.count != owningListCount {
            weightCurvePoints = [WeightCurvePointHash](repeating: WeightCurvePointHash(),
                                                                     count: owningListCount)
        }
        
        for guideIndex in 0..<owningListCount {
            let weightCurveControlPoint = owningList[guideIndex].weightCurvePoint
            weightCurvePoints[guideIndex].change(normalizedTanDirection: weightCurveControlPoint.normalizedTanDirection,
                                                        normalizedTanMagnitudeIn: weightCurveControlPoint.normalizedTanMagnitudeIn,
                                                        normalizedTanMagnitudeOut: weightCurveControlPoint.normalizedTanMagnitudeOut,
                                                        isManualHeightEnabled: weightCurveControlPoint.isManualHeightEnabled,
                                                        normalizedHeightFactor: weightCurveControlPoint.normalizedHeightFactor,
                                                        isManualTanHandleEnabled: weightCurveControlPoint.isManualTanHandleEnabled)
        }
        
        self.weightCurvePointEnd.change(normalizedTanDirection: weightCurvePointEnd.normalizedTanDirection,
                                               normalizedTanMagnitudeIn: weightCurvePointEnd.normalizedTanMagnitudeIn,
                                               normalizedTanMagnitudeOut: weightCurvePointEnd.normalizedTanMagnitudeOut,
                                               isManualHeightEnabled: weightCurvePointEnd.isManualHeightEnabled,
                                               normalizedHeightFactor: weightCurvePointEnd.normalizedHeightFactor,
                                               isManualTanHandleEnabled: weightCurvePointEnd.isManualTanHandleEnabled)
        
    }
    
}

