//
//  HistoryStateGrabAttributesAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/7/24.
//

import Foundation

public class HistoryStateGrabAttributesAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [GrabAttribute]
    public let endAttributes: [GrabAttribute]
    public init(jiggleIndex: Int,
         startAttributes: [GrabAttribute],
         endAttributes: [GrabAttribute]) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        super.init(.grabAttributesAll)
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
