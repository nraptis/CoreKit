//
//  HistoryStateGrabAttributeOne.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class HistoryStateGrabAttributeOne: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttribute: GrabAttribute
    public let endAttribute: GrabAttribute
    public init(jiggleIndex: Int,
         startAttribute: GrabAttribute,
         endAttribute: GrabAttribute) {
        self.jiggleIndex = jiggleIndex
        self.startAttribute = startAttribute
        self.endAttribute = endAttribute
        super.init(.grabAttributeOne)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let result = HistoryWorldConfiguration(documentMode: .view,
                                               editModeType: .dontCare,
                                               weightModeType: .dontCare,
                                               graphType: .dontCare,
                                               guidesType: .forceEnter,
                                               phoneExpandedTopType: .forceEnter,
                                               phoneExpandedBottomType: .dontCare,
                                               timeLineType: .dontCare,
                                               animationLoopType: .forceLeave,
                                               animationContinuousType: .forceLeave,
                                               animationLoopsPageType: .dontCare,
                                               animationTimeLinePageType: .dontCare,
                                               animationContinuousPageType: .dontCare,
                                               timeLineSwatchType: .dontCare,
                                               jigglePointTanType: .dontCare,
                                               guidePointTanType: .dontCare)
        return result
    }
}

