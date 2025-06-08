//
//  HistoryStateMoveWeightGraphPosition.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 5/16/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateMoveWeightGraphPosition: HistoryState {
    public let jiggleIndex: Int
    public let weightCurveIndex: Int
    public let startHeightManual: Bool
    public let startHeightFactor: Float
    public let endHeightFactor: Float
    public init(jiggleIndex: Int,
                weightCurveIndex: Int,
                startHeightManual: Bool,
                startHeightFactor: Float,
                endHeightFactor: Float,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.weightCurveIndex = weightCurveIndex
        self.startHeightManual = startHeightManual
        self.startHeightFactor = startHeightFactor
        self.endHeightFactor = endHeightFactor
        super.init(historyStateType: .moveWeightGraphPosition,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceEnter, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // TODO TODO TODO TODO
                                               guidePointTanType: .dontCare, // TODO TODO TODO TODO
                                               phoneExpandedTopType: .forceEnter, // Good
                                                // Good
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
