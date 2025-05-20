//
//  HistoryStateTransformJiggle.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public class HistoryStateTransformJiggle: HistoryState {
    
    public let jiggleIndex: Int
    public let startCenter: Math.Point
    public let startScale: Float
    public let startRotation: Float
    public let endCenter: Math.Point
    public let endScale: Float
    public let endRotation: Float
    public init(jiggleIndex: Int,
         startCenter: Math.Point, startScale: Float, startRotation: Float,
         endCenter: Math.Point, endScale: Float, endRotation: Float) {
        self.jiggleIndex = jiggleIndex
        self.startCenter = startCenter
        self.startScale = startScale
        self.startRotation = startRotation
        self.endCenter = endCenter
        self.endScale = endScale
        self.endRotation = endRotation
        super.init(.transformJiggle)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .edit, // Good
                                               editModeType: .dontCare, // Good
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
