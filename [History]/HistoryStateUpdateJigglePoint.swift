//
//  HistoryStateUpdateJigglePoint.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/14/25.
//

import Foundation

public class HistoryStateUpdateJigglePointOne: HistoryState {
    
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let startData: ControlPointData
    public let endData: ControlPointData
    public init(jiggleIndex: Int,
         controlPointIndex: Int,
         startData: ControlPointData,
         endData: ControlPointData) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.startData = startData
        self.endData = endData
        
        super.init(.updateJigglePointOne)
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
