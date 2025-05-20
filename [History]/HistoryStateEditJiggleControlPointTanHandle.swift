//
//  HistoryStateMoveJigglePointTanHandle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/21/24.
//

import Foundation

public class HistoryStateMoveJigglePointTanHandle: HistoryState {
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let tanType: TanType
    public let startData: ControlPointData
    public let endData: ControlPointData
    public init(jiggleIndex: Int,
                controlPointIndex: Int,
                tanType: TanType,
                startData: ControlPointData,
                endData: ControlPointData) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.tanType = tanType
        self.startData = startData
        self.endData = endData
        super.init(.editJigglePointTanHandle)
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
                                               jigglePointTanType: .forceEnter, // Good
                                               guidePointTanType: .dontCare) // Good
        return result
    }
    
}
