//
//  HistoryStateUpdateGuidePointAll.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateUpdateGuidePointAll: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let startDatas: [ControlPointData]
    public let endDatas: [ControlPointData]
    public init(jiggleIndex: Int,
                guideIndex: Int,
                startDatas: [ControlPointData],
                endDatas: [ControlPointData]) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.startDatas = startDatas
        self.endDatas = endDatas
        super.init(.updateGuidePointAll)
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
