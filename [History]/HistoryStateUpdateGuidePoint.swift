//
//  HistoryStateUpdateGuidePoint.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/14/25.
//

import Foundation

public class HistoryStateUpdateGuidePointOne: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let startData: ControlPointData
    public let endData: ControlPointData
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                startData: ControlPointData,
                endData: ControlPointData) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.startData = startData
        self.endData = endData
        
        super.init(.updateGuidePointOne)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .forceEnter(.points), // Good
                                               graphType: .forceLeave, // Good
                                               guidesType: .forceEnter, // Good
                                               phoneExpandedTopType: .dontCare, // Good
                                               phoneExpandedBottomType: .dontCare, // Good
                                               timeLineType: .dontCare, // Good
                                               animationLoopType: .dontCare, // Good
                                               animationContinuousType: .dontCare, // Good
                                               animationLoopsPageType: .dontCare, // Good
                                               animationTimeLinePageType: .dontCare, // Good
                                               animationContinuousPageType: .dontCare, // Good
                                               timeLineSwatchType: .dontCare, // Good
                                               jigglePointTanType: .dontCare, // Good
                                               guidePointTanType: .dontCare) // Good
        return result
    }
    
}
