//
//  HistoryStateUpdateJigglePointAll.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateUpdateJigglePointAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startDatas: [ControlPointData]
    public let endDatas: [ControlPointData]
    public init(jiggleIndex: Int,
                startDatas: [ControlPointData],
                endDatas: [ControlPointData]) {
        self.jiggleIndex = jiggleIndex
        self.startDatas = startDatas
        self.endDatas = endDatas
        super.init(.updateJigglePointAll)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .forceEnter(.points), // Good
                                               weightModeType: .dontCare, // Good
                                               graphType: .dontCare, // Good
                                               guidesType: .forceLeave, // Good
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
