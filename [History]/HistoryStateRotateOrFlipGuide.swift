//
//  HistoryStateRotateOrFlipGuide.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateRotateOrFlipGuide: HistoryState {
    
    public let jiggleIndex: Int
    public let guideIndex: Int
    public let startData: Data
    public let endData: Data
    public init(jiggleIndex: Int,
         guideIndex: Int,
         startData: Data,
         endData: Data) {
        self.jiggleIndex = jiggleIndex
        self.guideIndex = guideIndex
        self.startData = startData
        self.endData = endData
        super.init(.rotateOrFlipGuide)
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
