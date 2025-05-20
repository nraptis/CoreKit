//
//  HistoryStateRotateOrFlipJiggle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/8/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateRotateOrFlipJiggle: HistoryState {
    
    public let jiggleIndex: Int
    public let startData: Data
    public let endData: Data
    
    public init(jiggleIndex: Int,
         startData: Data,
         endData: Data) {
        self.jiggleIndex = jiggleIndex
        self.startData = startData
        self.endData = endData
        super.init(.rotateOrFlipJiggle)
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
