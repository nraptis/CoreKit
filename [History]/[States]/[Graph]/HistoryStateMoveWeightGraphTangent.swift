//
//  HistoryStateMoveWeightGraphTangent.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 5/16/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateMoveWeightGraphTangent: HistoryState {
    
    public let jiggleIndex: Int
    public let weightCurveIndex: Int
    public let startTangentManual: Bool
    public let startDirection: Float
    public let startMagnitudeIn: Float
    public let startMagnitudeOut: Float
    public let endDirection: Float
    public let endMagnitudeIn: Float
    public let endMagnitudeOut: Float
    public init(jiggleIndex: Int,
                weightCurveIndex: Int,
                startTangentManual: Bool,
                startDirection: Float,
                startMagnitudeIn: Float,
                startMagnitudeOut: Float,
                endDirection: Float,
                endMagnitudeIn: Float,
                endMagnitudeOut: Float,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.weightCurveIndex = weightCurveIndex
        self.startTangentManual = startTangentManual
        self.startDirection = startDirection
        self.startMagnitudeIn = startMagnitudeIn
        self.startMagnitudeOut = startMagnitudeOut
        self.endDirection = endDirection
        self.endMagnitudeIn = endMagnitudeIn
        self.endMagnitudeOut = endMagnitudeOut
        super.init(historyStateType: .moveWeightGraphTangent,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceEnter, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: .forceEnter, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .dontCare, // Good
                                               animationContinuousType: .dontCare, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare) // Good
        return result
    }
    
}
