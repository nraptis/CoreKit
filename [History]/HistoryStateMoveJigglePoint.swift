//
//  HistoryStateMoveJigglePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateMoveJigglePoint: HistoryState {
    
    public let jiggleIndex: Int
    public let controlPointIndex: Int
    public let startPoint: Math.Point
    public let endPoint: Math.Point
    public init(jiggleIndex: Int,
         controlPointIndex: Int,
         startPoint: Math.Point,
         endPoint: Math.Point) {
        self.jiggleIndex = jiggleIndex
        self.controlPointIndex = controlPointIndex
        self.startPoint = startPoint
        self.endPoint = endPoint
        super.init(.moveControlPoint)
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
