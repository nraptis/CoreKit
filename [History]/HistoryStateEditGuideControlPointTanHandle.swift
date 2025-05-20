//
//  HistoryStateMoveGuidePointTanHandle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/21/24.
//

import Foundation

public class HistoryStateMoveGuidePointTanHandle: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let tanType: TanType
    public let startData: ControlPointData
    public let endData: ControlPointData
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                tanType: TanType,
                startData: ControlPointData,
                endData: ControlPointData) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.tanType = tanType
        self.startData = startData
        self.endData = endData
        super.init(.editGuidePointTanHandle)
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
                                               guidePointTanType: .forceEnter) // Good
        return result
    }
}
