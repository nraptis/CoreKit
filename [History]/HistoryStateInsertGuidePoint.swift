//
//  HistoryStateInsertGuidePoint.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/19/25.
//

import Foundation

public class HistoryStateInsertGuidePoint: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let guidePointIndex: Int
    public let selectedGuidePointIndex: Int
    public let point: Math.Point
    public init(jiggleIndex: Int,
                guideIndex: Int,
                guidePointIndex: Int,
                selectedGuidePointIndex: Int,
                point: Math.Point) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.guidePointIndex = guidePointIndex
        self.selectedGuidePointIndex = selectedGuidePointIndex
        self.point = point
        super.init(.insertGuidePoint)
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
                                               guidePointTanType: .dontCare)  // Good
        return result
    }
    
}
