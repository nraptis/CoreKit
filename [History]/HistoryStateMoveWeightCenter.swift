//
//  HistoryStateMoveWeightCenter.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateMoveWeightCenter: HistoryState {
    
    public let jiggleIndex: Int
    public let startCenter: Math.Point
    public let endCenter: Math.Point
    public init(jiggleIndex: Int,
                startCenter: Math.Point,
                endCenter: Math.Point) {
        self.jiggleIndex = jiggleIndex
        self.startCenter = startCenter
        self.endCenter = endCenter
        super.init(.moveWeightCenter)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
                                               weightModeType: .dontCare, // Good
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
