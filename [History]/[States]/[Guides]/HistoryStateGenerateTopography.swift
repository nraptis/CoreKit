//
//  HistoryStateReplaceAllGuides.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

public class HistoryStateReplaceAllGuides: HistoryState {
    
    public let startDatas: [Data]
    public let endDatas: [Data]
    public let startWeightCenter: Math.Point
    public let endWeightCenter: Math.Point
    public let jiggleIndex: Int
    public let weightCurveIndex: Int?
    public init(jiggleIndex: Int,
                weightCurveIndex: Int?,
                startDatas: [Data],
                endDatas: [Data],
                startWeightCenter: Math.Point,
                endWeightCenter: Math.Point,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.weightCurveIndex = weightCurveIndex
        self.startDatas = startDatas
        self.endDatas = endDatas
        self.startWeightCenter = startWeightCenter
        self.endWeightCenter = endWeightCenter
        super.init(historyStateType: .replaceAllGuides,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare, // Good
                                               phoneExpandedTopType: .dontCare, // Good
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
