//
//  Jiggle+WeightGraphUpdate.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/9/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public extension Jiggle {
    
    func updateSelectedWeightCurvePointHeightFromGraph(tanFactorWeightCurve: Float) {
        weightCurve.refreshSpline(tanFactorWeightCurve: tanFactorWeightCurve)
        
    }
    
    func updateSelectedWeightCurvePointTanHandleIn(weightCurvePoint: WeightCurvePoint,
                                                          tanHandleX: Float,
                                                          tanHandleY: Float,
                                                   graphFrame: GraphFrame,
                                                          resetType: WeightCurveResetType,
                                                          index: Int,
                                                          numberOfPoints: Int) {
        let width = (graphFrame.width - graphFrame.paddingH - graphFrame.paddingH)
        let height = (graphFrame.height - graphFrame.paddingV - graphFrame.paddingV)
        let numberOfPoitnsf = Float(weightCurve.weightCurvePointCount - 1)
        if width > Math.epsilon && height > Math.epsilon {
            let handleX = (tanHandleX / (width)) * numberOfPoitnsf
            let handleY = tanHandleY / height
            let magnitudeSquared = handleX * handleX + handleY * handleY
            if magnitudeSquared > Math.epsilon {
                let magnitude = sqrtf(magnitudeSquared)
                weightCurvePoint.normalizedTanDirection = -atan2f(handleX, handleY)
                weightCurvePoint.normalizedTanMagnitudeIn = magnitude
                weightCurvePoint.isManualTanHandleEnabled = true
            }
        }
    }
    
    func updateSelectedWeightCurvePointTanHandleOut(weightCurvePoint: WeightCurvePoint,
                                                           tanHandleX: Float,
                                                           tanHandleY: Float,
                                                    graphFrame: GraphFrame,
                                                           resetType: WeightCurveResetType,
                                                           index: Int,
                                                           numberOfPoints: Int) {
        let width = (graphFrame.width - graphFrame.paddingH - graphFrame.paddingH)
        let height = (graphFrame.height - graphFrame.paddingV - graphFrame.paddingV)
        let numberOfPoitnsf = Float(weightCurve.weightCurvePointCount - 1)
        if width > Math.epsilon && height > Math.epsilon {
            let handleX = (tanHandleX / (width)) * numberOfPoitnsf
            let handleY = tanHandleY / height
            let magnitudeSquared = handleX * handleX + handleY * handleY
            if magnitudeSquared > Math.epsilon {
                let magnitude = sqrtf(magnitudeSquared)
                weightCurvePoint.normalizedTanDirection = -atan2f(-handleX, -handleY)
                weightCurvePoint.normalizedTanMagnitudeOut = magnitude
                weightCurvePoint.isManualTanHandleEnabled = true
            }
        }
    }
}
