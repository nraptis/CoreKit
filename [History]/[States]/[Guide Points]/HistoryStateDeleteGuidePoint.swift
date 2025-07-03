//
//  HistoryStateDeleteGuidePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateDeleteGuidePoint: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let data: ControlPointData
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                data: ControlPointData,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.data = data
        super.init(historyStateType: .deleteGuidePoint,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.points), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .forceLeave, // Good
                                               phoneExpandedTopType: .dontCare, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .dontCare, // Good
                                               animationContinuousType: .dontCare, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare)  // Good
        return result
    }
    
}
