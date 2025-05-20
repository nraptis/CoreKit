//
//  HistoryStateLoopAttributesAll.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/3/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public class HistoryStateLoopAttributesAll: HistoryState {
    
    public let jiggleIndex: Int
    public let startAttributes: [LoopAttribute]
    public let endAttributes: [LoopAttribute]
    public let selectedTimeLineSwatch: Swatch
    public init(jiggleIndex: Int,
                startAttributes: [LoopAttribute],
                endAttributes: [LoopAttribute],
                selectedTimeLineSwatch: Swatch) {
        self.jiggleIndex = jiggleIndex
        self.startAttributes = startAttributes
        self.endAttributes = endAttributes
        self.selectedTimeLineSwatch = selectedTimeLineSwatch
        super.init(.loopAttributesAll)
    }
    
    public override func getWorldConfiguration() -> HistoryWorldConfiguration {
        let loopAttributeType: LoopAttributeType
        if startAttributes.count > 0 {
            loopAttributeType = startAttributes[0].loopAttributeType
        } else {
            loopAttributeType = .timeLine
        }
        
        
        switch loopAttributeType {
        case .timeLine:
            // Here we don't care if
            // we're in time line or not...
            // we just need to be in loops...
            let result = HistoryWorldConfiguration(documentMode: .view,
                                                   editModeType: .dontCare,
                                                   weightModeType: .dontCare,
                                                   graphType: .dontCare,
                                                   guidesType: .dontCare,
                                                   phoneExpandedTopType: .dontCare,
                                                   phoneExpandedBottomType: .dontCare,
                                                   timeLineType: .dontCare,
                                                   animationLoopType: .forceEnter,
                                                   animationContinuousType: .forceLeave,
                                                   animationLoopsPageType: .dontCare,
                                                   animationTimeLinePageType: .dontCare,
                                                   animationContinuousPageType: .dontCare,
                                                   timeLineSwatchType: .exact(selectedTimeLineSwatch),
                                                   jigglePointTanType: .dontCare,
                                                   guidePointTanType: .dontCare)
            return result
        case .timeLineFrameOffset:
            // Here we go to time line page 2
            let result = HistoryWorldConfiguration(documentMode: .view,
                                                   editModeType: .dontCare,
                                                   weightModeType: .dontCare,
                                                   graphType: .dontCare,
                                                   guidesType: .dontCare,
                                                   phoneExpandedTopType: .dontCare,
                                                   phoneExpandedBottomType: .dontCare,
                                                   timeLineType: .forceEnter,
                                                   animationLoopType: .forceEnter,
                                                   animationContinuousType: .forceLeave,
                                                   animationLoopsPageType: .dontCare,
                                                   animationTimeLinePageType: .forcePage2,
                                                   animationContinuousPageType: .dontCare,
                                                   timeLineSwatchType: .exact(selectedTimeLineSwatch),
                                                   jigglePointTanType: .dontCare,
                                                   guidePointTanType: .dontCare)
            return result
        case .timeLineDuration:
            // Here we leave time line.
            let result = HistoryWorldConfiguration(documentMode: .view,
                                                   editModeType: .dontCare,
                                                   weightModeType: .dontCare,
                                                   graphType: .dontCare,
                                                   guidesType: .dontCare,
                                                   phoneExpandedTopType: .dontCare,
                                                   phoneExpandedBottomType: .dontCare,
                                                   timeLineType: .forceLeave,
                                                   animationLoopType: .forceEnter,
                                                   animationContinuousType: .forceLeave,
                                                   animationLoopsPageType: .dontCare,
                                                   animationTimeLinePageType: .dontCare,
                                                   animationContinuousPageType: .dontCare,
                                                   timeLineSwatchType: .exact(selectedTimeLineSwatch),
                                                   jigglePointTanType: .dontCare,
                                                   guidePointTanType: .dontCare)
            return result
        default:
            // Here we go to the time line.
            let result = HistoryWorldConfiguration(documentMode: .view,
                                                   editModeType: .dontCare,
                                                   weightModeType: .dontCare,
                                                   graphType: .dontCare,
                                                   guidesType: .dontCare,
                                                   phoneExpandedTopType: .forceEnter,
                                                   phoneExpandedBottomType: .dontCare,
                                                   timeLineType: .forceEnter,
                                                   animationLoopType: .forceEnter,
                                                   animationContinuousType: .forceLeave,
                                                   animationLoopsPageType: .dontCare,
                                                   animationTimeLinePageType: .dontCare,
                                                   animationContinuousPageType: .dontCare,
                                                   timeLineSwatchType: .exact(selectedTimeLineSwatch),
                                                   jigglePointTanType: .dontCare,
                                                   guidePointTanType: .dontCare)
            return result
        }
    }
    
}
