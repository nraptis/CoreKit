//
//  HistoryStateMoveGuidePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateMoveGuidePoint: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let startPoint: Math.Point
    public let endPoint: Math.Point
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                startPoint: Math.Point,
                endPoint: Math.Point,
                interfaceConfiguration: any InterfaceConfigurationConforming) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.startPoint = startPoint
        self.endPoint = endPoint
        
        super.init(historyStateType: .moveGuidePoint,
                   interfaceConfiguration: interfaceConfiguration)
    }
    
    public override func getWorldConfiguration(currentInterfaceConfiguration: any InterfaceConfigurationConforming, isUndo: Bool) -> HistoryWorldConfiguration {
        
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.points), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare,  // Good
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
